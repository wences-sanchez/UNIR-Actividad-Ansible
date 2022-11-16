# Actividad-1

- Installation of Wordpress based on the following link:
https://wordpress.org/support/article/how-to-install-wordpress/#detailed-instructions

## Requirements

1. [x] Download the wordpress package from `https://wordpress.org/latest.tar.gz` to /tmp
2. [] Extract the package
3. [] Create a database named *wordpress*
4. [] Create a user (e.g. *wordpress*)
5. [] Set a password for the above user
6. [] Grant all privileges to that user
7. [] Set *wp-config.php* as a configuration file
8. [] Create files to upload in the main folder
9. [] To test it all, visit `http://example.com/wp-admin/install.php`


## Development steps

- If not present, install molecule with `$ python3 -m pip install --user "molecule[docker]"` and `$ python3 -m pip install --user "ansible-lint"`
- Create the playbook tests using Molecule with `$ molecule init scenario`
- Instead of testing a role (because Molecule does not only test roles) we'll test our playbook
- We remove the role related lines in *converge.yml* and replace them with `- import_playbook: ../../main.yml` (at root indentation)
- We execute `$ molecule converge`
- What if docker is not working with Molecule? Just execute `$ molecule init scenario --driver-name docker`
- You don't need `become: true` if you're accesing a docker. In fact, it will make your playbook crash ;)
