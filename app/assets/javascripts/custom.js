 $('.article_link').click(function(e){

    e.preventDefault();

    $.ajax({

      url:'/articles',

      type:"GET",

      dataType: "json",

      success: function (data)

      {

        $('.panel-body').html(data);

      },

      error: function (xhr, status)

      {

        console.log(xhr.error);

      }

    });

  });


 $(function() {
  $(".pagination a").live("click", function() {
    $(".pagination").html("Page is loading...");
    $.getScript(this.href);
    return false;
  });
});
