<?php if(!class_exists('Rain\Tpl')){exit;}?><!DOCTYPE html>
<!--
    Hcode Store by hcode.com.br
-->
<html lang="pt-br">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" href="/fa32vicon.png"/>
    <title>Nilton Orquideas</title>
    
    <!-- Google Fonts -->
    <link href='http://fonts.googleapis.com/css?family=Titillium+Web:400,200,300,700,600' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Roboto+Condensed:400,700,300' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Raleway:400,100' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    
    <!-- Bootstrap -->
    <link rel="stylesheet" href="/res/site/css/bootstrap.min.css">
    
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css" integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay" crossorigin="anonymous">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="/res/site/css/owl.carousel.css">
    <link rel="stylesheet" href="/res/site/css/style.css">
    <link rel="stylesheet" href="/res/site/css/responsive.css">
    <link href='http://fonts.googleapis.com/css?family=Oleo+Script' rel='stylesheet' type='text/css'>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>
   
    <div class="header-area" style="background-color: #e6e6e6;">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <div class="user-menu">
                        <ul>
                            <?php if( checkLogin(false) ){ ?>
                            <li><a href="/profile"><i class="fa fa-user"></i> Olá <?php echo getUserName(); ?></a></li>
                            <li><a href="/cart"><i class="fas fa-shopping-basket"></i> Meu Carrinho</a></li>
                            <li><a href="/logout"><i class="fa fa-close"></i> Sair</a></li>
                            <?php }else{ ?>
                            <li><a href="/profile"><i class="fa fa-user"></i> Minha Conta</a></li>
                            <li><a href="/cart"><i class="fas fa-shopping-basket"></i> Meu Carrinho</a></li>
                            <li><a href="/login"><i class="fa fa-lock"></i> Login</a></li>
                            <?php } ?>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div> <!-- End header area -->
    
    <div class="site-branding-area" style="background-color: #ffffff;">
        <div class="container">
            <div class="row">
                <div class="col-sm-8">
                    <div class="logo" >
                      <h2 style="margin:0;text-align:left;font: 400 100px/1.3 'Oleo Script', Helvetica, sans-serif; color: #2b2b2b;text-shadow: 4px 4px 0px rgba(0, 0, 0, 0.22);">Nilton Orquídeas</h2>
                    </div>
                </div>
                
                <div class="col-sm-4">
                    <div class="shopping-item">
                        <a href="/cart">Carrinho - <span class="cart-amunt">R$<?php echo getCartVlSubTotal(); ?></span> <i class="fa fa-shopping-cart"></i> <span class="product-count"><?php echo getCartNrQtd(); ?></span></a>
                    </div>
                </div>
            </div>
        </div>
    </div> <!-- End site branding area -->
    
    <div class="mainmenu-area">
        <div class="container">
            <div class="row">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                </div> 
                <div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li class=""><a href="/">Home</a></li>
                        <li><a href="/products">Produtos</a></li>
                        <li><a href="/cart">Carrinho</a></li>
                    </ul>
                </div>  
            </div>
        </div>
    </div> <!-- End mainmenu area -->
