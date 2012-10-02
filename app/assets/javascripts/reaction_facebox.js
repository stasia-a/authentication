jQuery(document).ready(function() {
  $(document).bind('reveal.facebox', function() {
        $('#create_session').submit(function() {
            $.post(this.action, $(this).serialize(), null, "script");
            return false;
        });
    });
});