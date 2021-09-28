# MIMPM mimic alias manager

Expand your binary functionality by adding custom handlers<br>
or basically an advanced alias manager<br>


#### EXAMPLE: <br>
1. Mimic with custom alias<br>
`git sync "WIP: sync state"` - sync current source state with remote repository<br>
It is an interceptor or \<ALIAS\> `sync` for `git` \<MIMIC\><br>
Under the hood is does:<br>
`git add .`<br>
`git commit -am "WIP: sync state"`<br>
`git push`


2. Mimic with shorthand for specific key <br>
`npx init react-application` - create react project<br>
It is an interceptor or \<ALIAS\> `init` for `npx` \<BINARY\><br>
Under the hood is does: <br>
`npx create-react-app react-application`

3. Intercept existing command<br>
`git pull` - pull source from remote repository<br>
Under the hood is does: <br>
`git status` - to get current branch<br>
`git stash push` - to save current WIP<br>
`git pull origin <branch_from_status>` - to pull source<br>
`git stash pop` - to bring back WIP<br>
`date` - Indicate when it was done<br>
<b>*NOTE</b><br>
  to run original `git pull` prepend exclamation mark [!]<br>
  `git ! pull` - will ignore `pull` \<ALAIS\> and run  original `git pull`

# INSTALL

```
MIM_PATH="~/.local/share/mimpm"
git clone ${CURRENT_REPO_URL} ${MIM_PATH:-~/.mimpm}
cd ${MIM_PATH:-~/.mimpm}
./install.sh
```
It will add required exports to your `.bashrc` file

# USAGE
##### GENERAL INFO
<p>
  &emsp; <b>[MIMIC]</b> - is an excutable that handle calls </br>
    &emsp;&emsp; can be compiled binary or a shell script</br>
  &emsp; <b>[ALIAS]</b> - is a key for a [MIMIC]</br>
  E.g.:</br>
  &emsp;[MIMIC]&emsp;[ALIAS]</br>
  &emsp;&emsp;&emsp;ls&emsp;&emsp;&emsp;-la<br>
  &emsp;&emsp;&emsp;ip&emsp;&emsp;&emsp;route<br>
  &emsp;&emsp;&emsp;git&emsp; &emsp; status<br>
</p>

##### INFO:
  `mimpm <OPTION> [param1[ param2[...paramN]]]`
##### OPTIONS:
`--mimic-set-editor <bin_path>` - define preferred editor to use<br>
  &emsp; example:  `mimpm --mimic-set-editor vi`<br>

`--mimic-add <mimic> [<bin_path>]` - crate a [BINARY] interceptor<br>
  &emsp; example: `mimpm --mimic-add git /usr/bin/git`<br>
  &emsp;&emsp;  mimic `git` binary located at `/usr/bin/git`<br>
  &emsp;&emsp;  Then create aliases<br>
  &emsp;&emsp;  `git --mimic-add sync` - will create and open alias for editing<br>

`--mimic-remove <alias>` - remove alias<br>
  &emsp; example: `git --mimic-remove sync` - will remove sync alias file<br>

`--mimic-edit <alias>` - edit alias in preferred editor<br>
  &emsp; example: `git --mimic-edit sync`<br>

`--mimic-ls` - list defined aliases for current mimic<br>
  &emsp; example:
```
~$ git --mimic-ls
ca  commit all
cam  Commit all with simple message
ck  checkout
lsb  list all branches
lsc  list commits -> log --oneline
lsf  list files staged for commits
lsm  list merge commits
lst  list repo tags
pull  pull current branch from origin
push  push current branch to origin
st  show current repository status
sync  sync current state with remote. Push everything to remote
```
`--mimic-help [<alias>]` - show help for given mimic alias<br>
&emsp; example:
```
~$ git --mimic-help sync
sync current state with remote. Push everything to remote
USAGE: git sync "Commit message"
```

`--mimic-export [arg1[ arg2[ argN]]]` - export mimic alias for example to share with friend<br>
&emsp; `mimpm --mimic-export git` - export all defined git aliases<br>
&emsp; `mimpm --mimic-export git:sync` - export defined git sync alias<br>
&emsp; example: `mimpm --mimic-export git npx:init npm:reload`

`--mimic-import <alias_arch.tar>` - import mimic alias archive<br>

`--mimic-proxy` - create an interceptor for all calls except already defined aliases<br>
&emsp; `mimpm --mimic-proxy npm` - will create a proxy interceptor<br>
&emsp; means any `npm` calls will be routed to the proxy interceptor first<br>

`--mimic-disable <alias>` - temporary disable mimic for binary<br>
&emsp; example: `mimpm --mimic-disable git`

`--mimic-enable <alias>` - enable mimic
