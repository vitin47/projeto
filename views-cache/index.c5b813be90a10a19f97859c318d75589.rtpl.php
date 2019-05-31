<?php if(!class_exists('Rain\Tpl')){exit;}?><div class="slider-area">
            <!-- Slider -->
            <div class="block-slider block-slider4">
                <ul class="" id="bxslider-home4">
                    <li>
                        <img src="/res/site/img/1.png" alt="Slide">
                        <div class="caption-group">
                            <h2 class="caption title">
                                Lindas <span class="primary"> <strong>Orquideas</strong></span>
                            </h2>
                             <a class="caption button-radius" href="/categories/5"><i class="fas fa-arrow-right"></i> Comprar</a>
                        </div>
                    </li>
                    <li><img src="/res/site/img/2.png" alt="Slide">
                        <div class="caption-group">
                            <h2 class="caption title">
                                Aluguel <span class="primary"> <strong>Para eventos</strong></span>
                            </h2>
                            <a class="caption button-radius" href="https://api.whatsapp.com/send?phone=5531997148987&text=Ol%C3%A1%20Nilton%2C%20vim%20atrav%C3%A9s%20do%20seu%20site."><i class="fas fa-arrow-right"></i>Contato</a>
                        </div>
                    </li>
                    <li>
                        <img src="/res/site/img/3.png" alt="Slide">
                        <div class="caption-group">
                            <h2 class="caption title">
                                Produtos para<span class="primary"> <strong>manutenção</strong></span>
                            </h2>
                             <a class="caption button-radius" href="/categories/4"><i class="fas fa-arrow-right"></i> Comprar</a>
                        </div>
                    </li>
                </ul>
            </div>
            <!-- ./Slider -->
    </div> <!-- End slider area -->
    
    
    <div class="promo-area">
        <div class="zigzag-bottom"></div>
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-sm-4">
                    <div class="single-promo promo2">
                        <i class="fa fa-truck"></i>
                        <p>Entrega para todo o país</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4">
                    <div class="single-promo promo3">
                        <i class="fa fa-lock"></i>
                        <p>Site totalmente seguro</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4">
                    <div class="single-promo promo4">
                        <i class="far fa-credit-card"></i>
                        <p>Pagamento com Pageguro</p>
                    </div>
                </div>
            </div>
        </div>
    </div> <!-- End promo area -->


  
    <div class="maincontent-area">
        <div class="zigzag-bottom"></div>
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="latest-product">
                        <h2 class="section-title">Produtos</h2>
                        <div class="product-carousel">
                            <?php $counter1=-1;  if( isset($products) && ( is_array($products) || $products instanceof Traversable ) && sizeof($products) ) foreach( $products as $key1 => $value1 ){ $counter1++; ?>
                            <div class="single-product">
                                <div class="product-f-image">
                                    <img src="<?php echo htmlspecialchars( $value1["desphoto"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" alt="">
                                    <div class="product-hover">
                                        <a href="/cart/<?php echo htmlspecialchars( $value1["idproduct"], ENT_COMPAT, 'UTF-8', FALSE ); ?>/add" class="add-to-cart-link"><i class="fa fa-shopping-cart"></i> Comprar</a>
                                        <a href="/products/<?php echo htmlspecialchars( $value1["desurl"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" class="view-details-link"><i class="fa fa-link"></i>Detalhes</a>
                                    </div>
                                </div>
                                
                                <h2><a href="/products/<?php echo htmlspecialchars( $value1["desurl"], ENT_COMPAT, 'UTF-8', FALSE ); ?>"><?php echo htmlspecialchars( $value1["desproduct"], ENT_COMPAT, 'UTF-8', FALSE ); ?></a></h2>
                                
                                <div class="product-carousel-price">
                                    <ins>R$<?php echo formatPrice($value1["vlprice"]); ?></ins>
                                </div> 
                            </div>
                            <?php } ?>
                        </div>
                    </div>
                </div>
            </div>
            <br>

        </div>
          <div class="container">
        <h2 class="section-title">Cursos</h2>
             <h3>Como cultivar orquídeas?</h3><p>Muitas pessoas nos fazem essa pergunta, e pensando nisso resolvemos indicar alguns cursos que não foram feitos por nós, porém trazem um conteúdo muito interessante.</p>
        <div class="row"><br>
            <div class="col-md-4"><a href="https://go.hotmart.com/O13959948A" target="_blank"><img src="http://comocuidardeorquideas.com/wp-content/uploads/2017/06/2-1.jpg" border="0" width="336" height="280" /></a></div>
            <div class="col-md-4"><a href="https://go.hotmart.com/O13981457K" target="_blank"><img src="/res/site/img/1we.png" border="0" width="336" height="280" /></a></div>
            <div class="col-md-4"><a href="https://go.hotmart.com/A13981465X" target="_blank"><img src="/res/site/img/23123.png" border="0" width="336" height="280" /></a></div>
        </div>
    </div>
    </div> <!-- End main content area -->
    