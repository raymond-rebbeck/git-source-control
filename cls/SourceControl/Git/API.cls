Class SourceControl.Git.API
{

/// Configures settings for Git integration
ClassMethod Configure()
{
    set sc = $$$OK
    set initTLevel = $tlevel
    try {
        tstart
        $$$ThrowOnError(##class(%Studio.SourceControl.Interface).SourceControlClassSet("SourceControl.Git.Extension"))
        write !,"Configured SourceControl.Git.Extension as source control class for namespace ",$namespace
        set mappingsNode = ##class(SourceControl.Git.Utils).MappingsNode()
        if '$data(@mappingsNode) {
            do ##class(SourceControl.Git.Utils).SetDefaultMappings(mappingsNode)
            write !,"Configured default mappings for classes, routines, and include files. You can customize these in the global:",!?5,mappingsNode
        }
        set gitExists = ##class(SourceControl.Git.Utils).GitBinExists(.version)
        set gitBinPath = ##class(SourceControl.Git.Utils).GitBinPath(.isDefault)

        // Make sure they are using an appropriate git version
        if (+$PIECE(version,"version ",2))<2.31 {
            write !!, "WARNING: You are using an older version of git which is not compatible with git-source-control. Please upgrade to git version 2.31.0 or greater to continue"
            write !!, "Cancelling git-source-control configuration..."
            quit
        }
        if gitExists && isDefault {
            // Note: version starts with "git version"
            write !,version," is available via PATH. You may enter a path to a different version if needed."
        }
        set good = ##class(SourceControl.Git.Settings).Configure()
        if 'good {
            write !,"Cancelled."
            quit
        }
        tcommit
    } catch e {
        set sc = e.AsStatus()
        write !,$system.Status.GetErrorText(sc)
    }
    while $tlevel > initTLevel {
        trollback 1
    }
}

/// API for git pull - just wraps Utils
ClassMethod Pull()
{
    quit ##class(SourceControl.Git.Utils).Pull()
}

/// Locks the environment to prevent changes to code other than through git pull.
/// Returns 1 if the environment was already locked, 0 if it was previously unlocked.
ClassMethod Lock()
{
    quit ##class(SourceControl.Git.Utils).Locked(1)
}

/// Unlocks the environment to allow changes through the IDE.
/// Returns 1 if the environment was already locked, 0 if it was previously unlocked.
ClassMethod Unlock()
{
    quit ##class(SourceControl.Git.Utils).Locked(0)
}

/// Run in terminal to baseline a namespace by adding all items to source control.
/// - pCommitMessage: if defined, all changes in namespace context will be committed.
/// - pPushToRemote: if defined, will run a git push to the specified remote
ClassMethod BaselineExport(pCommitMessage = "", pPushToRemote = "") As %Status
{
    quit ##class(SourceControl.Git.Utils).BaselineExport(pCommitMessage, pPushToRemote)
}

}
