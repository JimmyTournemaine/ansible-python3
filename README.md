# ansible-python3

Build a the following docker image : 
- Ansible set up with Python3 and SSH support to deploy your project using Ansible

Python 3 could conflicted Python2 is the RHEL 7.7 distributions.
So, Python3/Ansible are isolated in a Python3 virtual environment (*venv*).

The container will be run with a non-root ansible user which can still use sudo without providing a password.
The Python 3 virtual environment is activated automatically. Run `deactivate` to exit it.

ansible-lint is also also installed to check the code quality of Ansible scripts.

## CI/CD Example

```yaml
# gitlab-ci.yml

image: 
  name: tzimy/ansible-python3

# Set workdir as roles path
variables:
  ANSIBLE_ROLES_PATH: "./roles:./roles/staging"

# Ansible root must no be world-writable
default:
  before_script: 
    - chmod -R o-rwx "$(pwd)"
    
tests:
  script:
    - ansible-playbook all.yml --check

syntax_check:
  script:
    - ansible-playbook --syntax-check all.yml

ansible_lint:
  script:
    - ansible-lint all.yml
```
