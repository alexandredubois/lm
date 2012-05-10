$(document).ready(function() 
                {
                    $("#hideButton").click(function ( event ) {
                        $(".movieCoverPic, .movieSummary").toggle();
                    });
                    $('#brandLogo').click(function() {
                        location.reload();
                    });
                } 
            );