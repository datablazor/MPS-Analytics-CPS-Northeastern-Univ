<?php

	///////////////////////////////////////////////////
	// CHANGE THESE VALUES AS NECESSARY
	///////////////////////////////////////////////////
	
	define( 'DB_SERVER', 'localhost' );
	define( 'DB_USER',   'root' );
	define( 'DB_PW',	 '' );
	define( 'DB_NAME',   'Chinook' );
	
	///////////////////////////////////////////////////

	define( 'PARAM_NAME', 'artist_name' );

	$param = 'black%';
	if ( isset( $_GET[ PARAM_NAME ] ) )
	{
		$param = trim( $_GET[ PARAM_NAME ] );
		if ( empty( $param ) )
		{
			$param = null;
		}
	}

?>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>MySQL/PHP Example</title>
		<link href="css/bootstrap.min.css" rel="stylesheet">
		
		<link rel="apple-touch-icon" sizes="57x57" href="./apple-touch-icon-57x57.png">
		<link rel="apple-touch-icon" sizes="60x60" href="./apple-touch-icon-60x60.png">
		<link rel="apple-touch-icon" sizes="72x72" href="./apple-touch-icon-72x72.png">
		<link rel="apple-touch-icon" sizes="76x76" href="./apple-touch-icon-76x76.png">
		<link rel="apple-touch-icon" sizes="114x114" href="./apple-touch-icon-114x114.png">
		<link rel="apple-touch-icon" sizes="120x120" href="./apple-touch-icon-120x120.png">
		<link rel="apple-touch-icon" sizes="144x144" href="./apple-touch-icon-144x144.png">
		<link rel="apple-touch-icon" sizes="152x152" href="./apple-touch-icon-152x152.png">
		<link rel="apple-touch-icon" sizes="180x180" href="./apple-touch-icon-180x180.png">
		<link rel="icon" type="image/png" href="./favicon-32x32.png" sizes="32x32">
		<link rel="icon" type="image/png" href="./android-chrome-192x192.png" sizes="192x192">
		<link rel="icon" type="image/png" href="./favicon-96x96.png" sizes="96x96">
		<link rel="icon" type="image/png" href="./favicon-16x16.png" sizes="16x16">
		<link rel="manifest" href="./manifest.json">
		<link rel="mask-icon" href="./safari-pinned-tab.svg" color="#5bbad5">
		<link rel="shortcut icon" href="./favicon.ico">
		<meta name="msapplication-TileColor" content="#da532c">
		<meta name="msapplication-TileImage" content="./mstile-144x144.png">
		<meta name="msapplication-config" content="./browserconfig.xml">
		<meta name="theme-color" content="#ffffff">
	</head>
	<body>
		<div class="container">
			
			<div class="page-header">
				<h1>MySQL/PHP Example</h1>
			</div>
			
			<form method="GET" action="<?php echo htmlentities( $_SERVER['PHP_SELF'] ); ?>">
				<div class="form-group">
					<label for="exampleInput">Artist (or blank for all)</label>
	    			<input type="text" class="form-control" id="exampleInput" name="<?php echo htmlentities( PARAM_NAME ); ?>" placeholder="n/a" value="<?php echo htmlentities( ( is_null( $param ) )?( '' ):( $param ) ) ?>">
				</div>
				<button type="submit" class="btn btn-default">Submit</button>
			</form>
			
			<hr />
			
			<p>
				<b>DB Connection</b>:
				<?php
				
					error_reporting( E_STRICT );
					mysqli_report( MYSQLI_REPORT_STRICT );
				
					try {
						$mysqli = new mysqli( DB_SERVER, DB_USER, DB_PW, DB_NAME );
						echo ( '<span class="label label-success">Success</span>' );
						$connected = true;
					} catch (Exception $e) {
						echo ( '<span class="label label-danger">' . htmlentities( $e->getMessage() ) . '</span>' );
						$connected = false;
					}
				?>
			</p>
			
			<?php 
				if ( $connected )
				{
			?>
					<p>
						<b>Character Set UTF-8</b>:
						<?php
							if (!$mysqli->set_charset('utf8')) {
								echo ( '<span class="label label-danger">' . htmlentities( $mysqli->error ) . '</span>' );
								$connected = false;
							} else {
								echo ( '<span class="label label-success">Success</span>' );
							}
						?>
					</p>
			<?php
				}
			?>
			
			<?php
				if ( $connected )
				{
			?>
			
				<hr />
			
				<p>
					<b>SQL to Prepare</b>:
					<?php
					
						$sql = null;
						if ( is_null( $param ) )
						{
							$sql = 'SELECT art.Name AS art_name, alb.Title AS alb_title' .
								   ' FROM album alb INNER JOIN artist art ON alb.ArtistId=art.ArtistId' .
								   ' ORDER BY art_name ASC, alb_title ASC';
						}
						else
						{
							$sql = 'SELECT art.Name AS art_name, alb.Title AS alb_title' .
								   ' FROM artist art INNER JOIN album alb ON art.ArtistId=alb.ArtistId' .
								   ' WHERE art.Name LIKE ?' .
								   ' ORDER BY art_name ASC, alb_title ASC';
						}
						
						echo ( '<code>' . htmlentities( $sql ) . '</code>' );
						
					?>
				</p>
				
				<p>
					<b>Preparing</b>:
					<?php
						if ( !( $stmt = $mysqli->prepare( $sql ) ) ) 
						{
							echo ( '<span class="label label-danger">' . htmlentities( $mysqli->error ) . '</span>' );
							return;
						}
						else
						{
							echo '<span class="label label-success">Success</span>';
						}
					?>
				</p>
				
				<?php
					if ( !is_null( $param ) )
					{
				?>
					<p>
						<b>Binding parameter</b>:
						<?php
							if ( !$stmt->bind_param( "s", $param ) ) 
							{
								echo ( '<span class="label label-danger">binding error</span>' );
								return;
							}
							else
							{
								echo '<span class="label label-success">Success</span>';
							}
						?>
					</p>
				<?php
					}
				?>
				
				<p>
					<b>Executing</b>:
					<?php
						if ( !$stmt->execute() ) 
						{
							echo ( '<span class="label label-danger">' . htmlentities( $stmt->error ) . '</span>' );
							return;
						}
						else
						{
							echo '<span class="label label-success">Success</span>';
						}
					?>
				</p>
				
				<hr />
				
				<p>
					<h1>Results</h1>
					<ul class="list-group">
					<?php
						
						$artist_name = null;
						$album_name = null;
						$stmt->bind_result( $artist_name, $album_name );
						
						while ( $stmt->fetch() )
						{
							echo '<li class="list-group-item">';
							echo ( '<h4 class="list-group-item-heading">' . htmlentities( $artist_name ) . '</h4>' );
							echo ( '<p class="list-group-item-text">' . htmlentities( $album_name ) . '</p>' );
							echo '</li>';
						}
						
						$stmt->close();
						
					?>
				</ul>
				</p>
				
				<hr />
			
				<p>
					<b>DB Disconnection</b>:
					<?php
						echo ( ( $mysqli->close() )?( '<span class="label label-success">Success</span>' ):( '<span class="label label-danger">Failure</span>' ) );
					?>
				</p>
			
			<?php
				}
			?>
	</div>
	
	<script src="js/jquery-1.12.0.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	</body>
</html>
