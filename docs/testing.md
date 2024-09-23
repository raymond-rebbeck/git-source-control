# git-source-control Testing Plan

The following is a testing plan that should be followed prior to release of a new version.

- Using a IRIS user with %All permissions, run `##class(SourceControl.Git.API).Configure()` in a terminal on a fresh namespace. Terminal prompts should describe each setting. Create an SSH key and use it to clone a remote repository.
- The following steps should be run with an IRIS user with %Developer role (not %All).
- Use VS Code to create a new class. Use the Source Control menu to Import All from the repository. Check the output to confirm that the contents of the repository were imported and compiled.
- Test changing Git project settings in a web browser and in Studio. Input labels and tooltips should describe each setting.
- In Expert Mode, test:
  - Add a new item through Studio / VS Code. Use the Add option in the Source Control Menu. The item should show up in the Workspace view of the WebUI.
  - Stash the item in the WebUI. It should be deleted from IRIS. Pop it from the stash. It should be imported and compiled. Discard the item in the WebUI. It should be deleted from IRIS.
  - Add, delete, and modify some items in Studio / VS Code. Commit through the WebUI with a commit message and details. The commit should show with the expected commit message and differences in the branch view.
  - Select the branch in the branch view and click "Push Branch". It should successfully push changes to the remote repository.
  - Create a new local branch. Add a new item and commit it. Switch between the new branch and the old branch. The item should be added and deleted from IRIS. Test merging the new branch to the old branch in the web UI. The item should be added to IRIS.
  - Edit a file on the remote repository. Use the "Git Pull" link from the System Management Portal favorites to pull. The preview should show the change without actually pulling it or loading it into IRIS. Confirming should do the pull and load the change into IRIS.
  - Edit an item through Studio / VS Code. Log in with a different IRIS user and attempt to edit the same item. The edit should be prohibited. Open the WebUI. The workspace view should list that item and indicate that it is checked out by another user. Stash the item, then try to edit it again. This time the edit should succeed.
- In Basic Mode, test:
  - Add, edit, and delete items through Studio / VS Code. Use the Sync option. All changes should be committed and pushed to the remote.
  - Add, edit, and delete items on the remote. Add, edit, and delete unrelated items through Studio/VSCode. All changes should be pulled, committed, and pushed.
  - Add an item to an interoperability production and sync. Check out a new feature branch. The item should no longer exist in the production. Set the previous branch as the remote merge branch. Sync. The new item should exist in the production.
  - Add an item to a production and sync. Check out a new feature branch. The item should no longer exist in the production. Set the previous branch as the remote merge branch. Add a new item to the production. Sync. The production should now have both new items, and the source control output should show it automatically resolved a conflict.