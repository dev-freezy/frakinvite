
let linviterId = null;
let ljobname = null;

$(function() {
    window.addEventListener('message', function(event) {
        if (event.data.type === "showInvite") {
            linviterId = event.data.inviterId;
            ljobname = event.data.jobname;
            let messageText = $('#inviteMessage').text().replace('$jobname$', ljobname);
            $('#inviteMessage').text(messageText);
            $('#inviteContainer').show();
        } else if (event.data.type === "close"){
            $('#inviteContainer').hide();
        }
    });

    $("#accept").click(function() {
        $.post(`https://${GetParentResourceName()}/acceptInvite`, JSON.stringify({ jobname: ljobname, inviterId: linviterId }));
        $('#inviteContainer').hide();
    });

    $("#decline").click(function() {
        $.post(`https://${GetParentResourceName()}/declineInvite`, JSON.stringify({ jobname: ljobname, inviterId: linviterId }));
        $('#inviteContainer').hide();
    });
});
