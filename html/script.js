let linviterId = null;
let ljobname = null;

$(function() {
    $('#frakinvite-text').text(config.frakinviteText);
    $('#server-name').text(config.serverName);

    $('#accept-button').text(config.acceptButtonText);
    $('#decline-button').text(config.declineButtonText);

    window.addEventListener('message', function(event) {
        if (event.data.type === "showInvite") {
            linviterId = event.data.inviterId;
            ljobname = event.data.jobname;
            $('#invite-text').html(config.inviteText.replace('§Name§', event.data.inviterName).replace('§Job§', event.data.joblabel))
            $('#gradient-border').show();
        } else if (event.data.type === "close") {
            $('#gradient-border').hide();
        }
    });

    $("#accept-button").click(function() {
        $.post(`https://${GetParentResourceName()}/acceptInvite`, JSON.stringify({ jobname: ljobname, inviterId: linviterId }));
        $('#gradient-border').hide();
    });

    $("#decline-button").click(function() {
        $.post(`https://${GetParentResourceName()}/declineInvite`, JSON.stringify({ jobname: ljobname, inviterId: linviterId }));
        $('#gradient-border').hide();
    });
});