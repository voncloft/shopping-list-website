 <?php
 error_reporting( ~E_DEPRECATED & ~E_NOTICE );
 
 define('DBHOST', 'localhost');
 define('DBUSER', 'your_user_here');
 define('DBPASS', 'your_password_here');
 define('DBNAME', 'shopping_list');
 
 $conn = new mysqli(DBHOST,DBUSER,DBPASS,DBNAME);
 
 if ( !$conn ) {
        echo "Failed to connect to MySQL: " . $conn -> connect_error;
 }
?>
