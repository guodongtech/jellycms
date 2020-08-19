
//Swiper5
  var mySwiper = new Swiper ('.swiper-container', {
   // direction: 'herizon', // 垂直切换选项
    loop: true, // 循环模式选项
	 autoplay: {
	  disableOnInteraction: false, //手动滑动之后不打断播放
	  delay: 2888
	},
    on:{
      init: function(){
        swiperAnimateCache(this); //隐藏动画元素 
        swiperAnimate(this); //初始化完成开始动画
      }, 
      slideChangeTransitionEnd: function(){ 
        swiperAnimate(this); //每个slide切换结束时也运行当前slide动画
        //this.slides.eq(this.activeIndex).find('.ani').removeClass('ani'); 动画只展现一次，去除ani类名
      } 
    }
  }) 

var wow = new WOW({
    boxClass: 'wow',
    animateClass: 'animated',
    offset: 0,
    mobile: true,
    live: true
});
wow.init();
var navw = $('#mobile-nav').innerWidth(); //导航宽度
var headh = $('header').innerHeight();	//头部高度
var footerh = $('footer').innerHeight(); //底部高度
var b_t = 0;	//展开导航后的 body 偏移量
var bobyl = navw+b_t;
$('#mobile-nav').stop().css({'marginRight':-navw});
$('#default-mobile-spacing-header').css({'height':headh});
$('#default-mobile-spacing-footer').css({'height':footerh});
$('.nav-button div').click(function(){
	if($('body').hasClass('nav-on')){
		off();
	} else {
		on();
	}
});
function off(){
	$('.nav-button .close').hide();
	$('.nav-button .open').show();
	$('body').stop().animate({'left':0,'top':0},500);
	$('#mobile-nav').stop().animate({'marginRight':-navw},500);
	$('body').removeClass('nav-on').addClass('nav-off');
	$('footer,header').stop().animate({'left':0},500);
}
function on(){
	$('.nav-button .open').hide().siblings('.nav-button .close').show();
	$('body').removeClass('nav-off').addClass('nav-on');
	$('body').stop().animate({'left':-bobyl,'top':b_t},500);
	$('footer,header').stop().animate({'left':-navw},500);
	$('#mobile-nav').stop().animate({'marginRight':0},500);

}

var $scroll = $(document).scrollTop();
var direction;
$(document).scroll(function() {
	if($('header').length && $('footer').length){
		var ht = $('header').position().top;
		var ft = parseInt($('footer').css('bottom'));
		if($scroll > $(document).scrollTop()){
			direction = 'down';
		} else {
			direction = 'up';
		}
		if(direction == 'up'){
			if(ht == 0 && $(document).scrollTop() > 50){
				$('header').stop().animate({'top':-headh},500);
			}
			if(ft < 0){
				$('footer').stop().animate({'bottom':0},500);
			}
		} else if(direction == 'down'){
			if(ht < 0){
				$('header').stop().animate({'top':0},500);
			}
			if(ft == 0){
				$('footer').stop().animate({'bottom':-footerh},500);
			}
		}	
		$scroll = $(document).scrollTop();
	}
});