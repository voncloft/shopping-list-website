 <?php
 //session_start();
 include_once 'passwords.config.php';
 error_reporting( ~E_DEPRECATED & ~E_NOTICE );

 $GLOBALS['conn'] = new mysqli(DBHOST,DBUSER,DBPASS,DBNAME);
 
 if ( !$conn ) {
        echo "Failed to connect to MySQL: " . $conn -> connect_error;
 }
?>
