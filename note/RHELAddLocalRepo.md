RHEL添加本地源（光盘）
```bash
cat /etc/yum.repos.d/rhel-local.repo

[rhel6.3-local]
name=RHEL 6.3 local repository
baseurl=file:///opt/yum/rhel6.3/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
enabled=1
```
