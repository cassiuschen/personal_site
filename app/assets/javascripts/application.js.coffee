# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https:#github.com/rails/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery.turbolinks
#= require jquery_ujs
#= require classie
#= require modernizr
#= require masonry/jquery.masonry
#= require masonry/jquery.imagesloaded.min
#= require masonry/jquery.infinitescroll.min
#= require turbolinks
#= require snap-svg
#= require notificationFX
#= require rails-timeago-all
#= require nprogress
#= require nprogress-turbolinks
# require nprogress-ajax-prototype
#= require typed
# require hightlight
# require_tree .

NProgress.configure
  showSpinner: false
  ease: 'ease',
  speed: 500

window.sidebarOpen = false

window.base = 
  sideBarToggle: ->
    $("#sidebar_control").click ->
      $('body').toggleClass "nav-open"
      window.sidebarOpen = !(window.sidebarOpen)
      if window.sidebarOpen == true
        $('a.link').click ->
          $('body').removeClass "nav-open"
        $('.dimmer').click ->
          $('body').removeClass "nav-open"

  horizonCenter : (el) ->
    windowWidth = $(window).width()
    elWidth = $(el).width()
    $(el).css 'left', ((windowWidth - elWidth) / 2)
  pinterestLayout : ->
    $pinterest = $('.things').masonry
      itemSelector: '.thing'
      gutterWidth: 5
      isAnimated: true
    $pinterest.imagesLoaded ->
      console.log 'pinterest'
      $pinterest.masonry
        itemSelector: '.thing'
        gutterWidth: 5
        isAnimated: true
  init: ->
    window.sidebarOpen = false
    window.base.sideBarToggle()
    window.base.pinterestLayout()
    #hljs.initHighlightingOnLoad();

window.notification = 
  info : (text) ->
    notification = new NotificationFx
      wrapper : document.getElementsByTagName("main")[0]
      message : "<p>#{text}</p>"
      layout : 'growl'
      effect : 'jelly'
      type : 'notice'
      onClose : ->
        console.log 'close a notification'

    notification.show()


$(document).on 'page:change', ->
  console.log 'init'
  window.base.init()

$(document).on 'page:load', ->
  console.log 'page:load'

