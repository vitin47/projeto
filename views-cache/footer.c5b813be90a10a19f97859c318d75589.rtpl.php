<?php if(!class_exists('Rain\Tpl')){exit;}?><div class="footer-top-area">
        <div class="zigzag-bottom"></div>
        <div class="container">
            <div class="row">
                <div class="col-md-3 col-sm-6">
                    <div class="footer-about-us">
                        <h2>Sobre:</h2>
                        <p>À mais de 20 anos no ramo de orquideas, agora para o maior conforto dos nossos clientes presente também no ambiente virtual.
                            <br>
                            Em um site simples, eficiente e confiável para adquirir e aprender mais sobre a nossa paixão, as orquideas.
                        </p>
                        <div class="footer-social">
                            <a href="https://api.whatsapp.com/send?phone=5531997148987&text=Ol%C3%A1%20Nilton%2C%20vim%20atrav%C3%A9s%20do%20seu%20site." target="_blank"><i class="fab fa-whatsapp"></i></a>
                            <a href="https://www.instagram.com/niltonorquideas/" target="_blank"><i class="fab fa-instagram"></i></a>
                            <a href="https://www.youtube.com/channel/UCc2DqL_n22mInrYfbY1Afbg?view_as=subscriber" target="_blank"><i class="fab fa-youtube"></i></a>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-3 col-sm-6">
                    <div class="footer-menu">
                        <h2 class="footer-wid-title">Navegação </h2>
                        <ul>
                            <li><a href="/profile">Minha Conta</a></li>
                            <li><a href="/profile/orders">Meus Pedidos</a></li>
                            <li><a href="">Lista de Desejos</a></li>
                        </ul>                        
                    </div>
                </div>
                
                <div class="col-md-3 col-sm-6">
                    <div class="footer-menu">
                        <h2 class="footer-wid-title">Categorias</h2>
                        <ul>
                            <?php require $this->checkTemplate("categories-menu");?>
                        </ul>                        
                    </div>
                </div>
                
                <div class="col-md-3 col-sm-6">
                    <div class="footer-newsletter">
                        <h2 class="footer-wid-title">Promoções</h2>
                        <p>Digite aqui seu e-mail para ficar por dentro das nossas promoções"</p>
                        <div class="newsletter-form">
                            <form method="get" action="/email">
                                <input type="email" name="email" placeholder="Digite seu email">
                                <input type="submit" value="Enviar">
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div> <!-- End footer top area -->
    
 
    
   
    <!-- Latest jQuery form server -->
    <script src="https://code.jquery.com/jquery.min.js"></script>
    
    <!-- Bootstrap JS form CDN -->
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    
    <!-- jQuery sticky menu -->
    <script src="/res/site/js/owl.carousel.min.js"></script>
    <script src="/res/site/js/jquery.sticky.js"></script>
    
    <!-- jQuery easing -->
    <script src="/res/site/js/jquery.easing.1.3.min.js"></script>
    
    <!-- Main Script -->
    <script src="/res/site/js/main.js"></script>
    
    <!-- Slider -->
    <script type="text/javascript" src="/res/site/js/bxslider.min.js"></script>
	<script type="text/javascript" src="/res/site/js/script.slider.js"></script>
  </body>
</html>