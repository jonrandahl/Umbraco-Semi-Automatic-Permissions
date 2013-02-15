#Umbraco Semi-Automatic Permissions
==================================

A simple batch file which prompts the user for the Application Pool name and sets the correct permissions to your local Umbraco install. Easy to be extended and hopefully forked and expanded upon!

Based on the works of Matt Brailsford, Sebastiaan Janssen, Ove Anderson and others. I take no credit in the initial creation of this script simply the extension and addtion of the user-prompt-ability.

It could use some more tweaking for individual directory structures, and this has not been tested on v6.x at all yet, but it shoud be a good place to start!

Jon - [@precisioncoding](https://twitter.com/precisioncoding)

##Instructions:
1. Simply copy this script
2. And drop it in the following location:
`C:\Users\[YOUR_USERNAME]\AppData\Roaming\Microsoft\Windows\SendTo\SetUmbracoPermissions.bat`
3. Then right click on the root folder, and select “Send to > SetUmbracoPermissions.bat” to setup the relevant permissions.

[Matt Brailsford][3] noted on his page:
> if you are **NOT** using Windows Server 2008, you’ll need to change your app pools identity to NETWORK SERVICE. 

---

> Matt Brailsford - [@mattbrailsford](https://twitter.com/mattbrailsford)
> Sebastiaan Janssen - [@cultiv](https://twitter.com/cultiv)
> Ove Anderson - [@azzlack](https://twitter.com/azzlack)

---

###Further Reading:
* [Adding a Windows Context Menu Item to Set Umbraco Folder Permissions ~ Matt Brailsford][3]
* [Set Umbraco Folder Permissions from command line ~ our.umbraco.org][2]
* [Permissions ~ our.umbraco.org][1]

[1]: http://our.umbraco.org/wiki/reference/files-and-folders/permissions
[2]: http://our.umbraco.org/wiki/install-and-setup/set-umbraco-folder-permissions-from-command-line
[3]: http://blog.mattbrailsford.com/2010/08/01/adding-a-windows-context-menu-item-to-set-umbraco-folder-permissions/
