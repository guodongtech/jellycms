//Swiper5
  var mySwiper = new Swiper ('.swiper-container', {
   // direction: 'herizon', // 垂直切换选项
    loop: true, // 循环模式选项
    
    // 如果需要分页器
    pagination: {
      el: '.swiper-pagination',
    },
    
    // 如果需要前进后退按钮
    navigation: {
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev',
    },
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
  
  
$(document).ready(function (){
	$(window).scroll(function(){
		//获取当前鼠标滑动的高度
		var currentTop = $(window).scrollTop();
		var offset = $('.sta-left').offset();
		//导航菜单
		if(currentTop>=32){
			$('header').addClass('active');
		}else if(currentTop<32){
			$('header').removeClass('active');
		}
		//计数
		if(0){
			$('.count').each(function() {
				$(this).animate({
					counter: $(this).attr('counter')
				}, {
					duration: 2000,
					easing: 'swing',
					step: function(now) {
						now = Math.ceil(now);
						var str = now.toString();
						var reg = str.indexOf(".") > -1 ? /(\d)(?=(\d{3})+\.)/g : /(\d)(?=(?:\d{3})+$)/g;
						$(this).text(str.replace(reg,"$1,"));
					}
				});
			});
		}
	});
});  
  
var wow = new WOW({
    boxClass: 'wow',
    animateClass: 'animated',
    offset: 0,
    mobile: true,
    live: true
});
wow.init();
  