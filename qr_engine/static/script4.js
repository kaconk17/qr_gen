

$(document).ready(function(){
    
    $("#frm_input").submit(function(e){
        e.preventDefault();
        var datas = $(this).serialize();
        var btn = $("#btn_gen");
        var title = $("#inputan").val();
        btn.attr('disabled', true);
        $.ajax({
            url: 'genqr',
            type: 'POST',
            dataType: 'json',
            data: datas,
        })
        .done(function(resp) {
            
          if (resp.success) {
            $("#img_container").html("<img src='data:image/png;base64,"+resp.img+"' class='img-fluid'>");
            $("#title").text(title);
            $("#download").html("<a class='btn btn-primary' href='#' onclick='get_img(this)' download='"+ title+".png'>Download</a>")
            $('#mymodal').modal('show');
          }
           
        })
        .fail(function() {
            $("#error").html("<div class='alert alert-danger'><div>Tidak dapat terhubung ke server !!!</div></div>");
             //toastr['warning']('Tidak dapat terhubung ke server !!!');
        })
        .always(function() {
           
        });
    });

});