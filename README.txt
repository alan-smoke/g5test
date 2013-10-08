_______________________________________________________________________________________________

If you are running on a Windows environment and you do not have MySql or Ruby on Rails installed, perform the following steps.

1. Download the MSI installer for MySql from dev.mysql.com/downloads/installer/5.6.html.  (Requires an Oracle login)
2. Install msi package using default options
3. When prompted for the root password, enter root123
3. Download Connector C from http://dev.mysql.com/downloads/connector/c/
4. Install using default options, and the Typical installation type.
5. Download the windows rails installer from http://rubyforge.org/frs/download.php/76862/railsinstaller-2.2.1.exe
6. Install using default options
7. Open Command Prompt as Administrator
8. Enter "cd C:\RailsInstaller\DevKit"
9. Enter "ruby dk.rb init"
10 Enter "ruby dk.rb install"
11. Copy C:\Program Files (x86)\MySQL\MySQL Connector C 6.1\lib\libmysql.dll to C:\Ruby193\bin


_______________________________________________________________________________________________


Database preparation steps

1. Open Command Prompt as Administrator
2. Enter "cd C:\Program Files\MySQL\MySQL Server 5.6\bin"
3. Enter "mysql -u root -p"
4. When prompted for the password, enter "root123"
5. At the msql command prompt enter "create database g5test;"
6. Enter "CREATE USER 'g5test'@'localhost' IDENTIFIED BY 'g5test!@#456'";
6. Enter "GRANT ALL PRIVILEGES ON g5test.* TO 'g5test'@'localhost' WITH GRANT OPTION;"
7. Enter "quit"


_______________________________________________________________________________________________

Use Github to download G5test code

1. username = alan-smoke
2. password = github123

_______________________________________________________________________________________________

Install gems

1. Open Command Prompt as Administrator
2. Navigate to g5test directory installed from Github
3. Enter "gem install bundler"
4. Enter "gem install mysql2 --platform=ruby -- '--with-mysql-lib="C:\Program Files (x86)\MySQL\MySQL Connector C 6.1\lib" --with-mysql-include="C:\Program Files (x86)\MySQL\MySQL Connector C 6.1\include" --with-mysql-dir="C:\Program Files (x86)\MySQL\MySQL Connector C 6.1"'"
4. Enter "bundle install"

_______________________________________________________________________________________________

Setup Application

1. Open Command Prompt as Administrator
2. Navigate to g5test directory installed from Github
3. Enter "rake db:migrate"
4. Enter "rake db:seed" 

_____________________________________________________________________________________________

Run Application


1. Open Command Prompt as Administrator
2. Navigate to g5test directory installed from Github
3. Enter "ruby.exe ./script/rails server -b 127.0.
0.1 -p 3000 -e development"
4. Open a browser and enter "http://localhost:3000/tour_request"




