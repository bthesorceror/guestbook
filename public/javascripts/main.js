function ViewModel(){
  var self = this;
  self.posts = ko.observableArray([]);
  self.users = ko.observableArray([]);
  self.message = ko.observable("");
  self.alert = ko.observable(null);
  self.logged_in = ko.observable(false);
  self.not_logged_in = ko.computed(function(){ return !self.logged_in(); });
  self.username = ko.observable("");
  self.first_run = true;

  self.get_posts = function() {
    var attributes = self.posts()[0] ? { id: self.posts()[0].id } : {}
    $.get('/wall.json', attributes, self.update_posts);
  }

  self.update_message = function(message) {
    $(".alert-message").show();
    self.alert(message);
    $(".alert-message").fadeOut(5000);
  }

  self.update_posts = function(data) {
    self.users(data.users);
    self.logged_in(data.logged_in);
    self.username(data.username);
    $.each(data.posts.reverse(), function(index, value){
      self.posts.unshift(value);
    });
    $(".wall_post_timestamp").livequery(function () { $(this).timeago(); });
    if (self.first_run) {
      self.first_run = false;
    }
  }

  self.after_post = function(domNode, element) {
    if (!self.first_run) {
      var $el = $('#wall #' + element.id);
      $el.effect("highlight", {}, 3000);
    }
  }

  self.post_message = function() {
    $.post('/wall.json', {message: self.message});
    self.update_message("Message Posted!");
    self.message("");
    self.get_posts();
  }

  self.show_main = function(e) {
    $('.page').hide();
    $('#main').show();
  }

  self.show_about = function(e) {
    $('.page').hide();
    $('#about').show();
  }

  self.get_posts();
  setInterval(self.get_posts, 15000);
}

$(document).ready(function() {
  ko.applyBindings(new ViewModel());
});
