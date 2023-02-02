Linux-ubuntu系統
step1:
sudo apt-get update
sudo apt-get install r-base
step2:
sudo apt-get install libmariadbclient-dev
step3:
cd TAG_CODE
step4:
sudo Rscript main_competitor.R

Linux-centos系統
step1:
sudo dnf install epel-release
sudo dnf config-manager --set-enabled PowerTools
sudo yum install R
step2:
sudo yum install mysql-devel
step3:
cd TAG_CODE
step4:
sudo Rscript main_competitor.R
