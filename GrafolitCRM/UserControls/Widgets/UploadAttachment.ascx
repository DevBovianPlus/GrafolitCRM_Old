<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UploadAttachment.ascx.cs" Inherits="AnalizaProdaje.UserControls.Widgets.UploadAttachment" %>

<script type="text/javascript">
    var documentContainerID = '<%= this.WebsiteDocumentContainerID%>';
    $(document).ready(function () {
        $('[data-toggle="popover"]').popover({ html: true });
    });
    
    function onUploadControlFileUploadComplete(s, e) {
        var obj = jQuery.parseJSON(e.callbackData);
        if (obj != null) {
            $('#' + documentContainerID).append("<a class='uploaded-link' href='#' data-toggle='popover'" +
                                " data-placement='left' data-trigger='focus' title='Možnosti' data-content='" +
                                "<a class=\"documentOpen\" href=\"" + obj.Url + "\" target=\"_blank\">Odpri</a>" +
                                "<div class=\"documentDelete\" data-document=\"" + obj.Name + "\">Izbriši</div>" +
                                "<div class=\"documentDownload\" data-document=\"" + obj.Name + "\">Prenesi</div>'>" +
                                "<div class='uploaded-doc" + (obj.isImage ? " uploaded-image'" : "'") + "><span title=" + obj.Name + ">" + obj.Name + "</span></div></a>");
            $('[data-toggle="popover"]').popover({ html: true });
        }
    }

    function setElementVisible(elementId, visible) {
        //document.getElementById(elementId).className = visible ? "" : "hidden";
        if (visible)
            $(elementId).removeClass("hidden");
        else
            $(elementId).addClass("hidden");
    }
    function OnDropZoneEnter(s, e) {
        var dropZone = clientHfDropZone.Get('DropZone');
        if (e.dropZone.id == dropZone)
            setElementVisible('#' + documentContainerID, true);
    }
    function OnDropZoneLeave(s, e) {
        var dropZone = clientHfDropZone.Get('DropZone');
        if (e.dropZone.id == dropZone)
            setElementVisible('#' + documentContainerID, false);
    }

    

    $(document).on('click', '.documentDelete', function (e) {
        var obj = $(this).data("document");
        
        $(this).closest('.popover').prev().remove();

        clientCallbackUploadControl.PerformCallback('Delete;' + obj);
    });
    $(document).on('click', '.documentDownload', function (e) {
        var obj = $(this).data("document");

        clientCallbackUploadControl.PerformCallback('Download;' + obj);
    });
</script>

<div id="externalDropZone" class="external-drop-zone hidden" runat="server">
    <div id="dragZone">
        <span class="dragZoneText">Povleci profilno sliko v okvir</span>
    </div>
    <div id="dropZone" class="hidden">
        <span class="dropZoneText">Drop an image here</span>
    </div>

</div>
<div style="display: block; width: 100%; overflow: hidden">
    <dx:ASPxHiddenField ID="hfDropZone" ClientInstanceName="clientHfDropZone" runat="server" />
    <dx:ASPxUploadControl ID="UploadControl" runat="server" UploadMode="Auto" Width="100%"
        ClientInstanceName="clientUploadControl" AutoStartUpload="true" ShowProgressPanel="true" DialogTriggerID="externalDropZone"
        OnFileUploadComplete="UploadControl_FileUploadComplete">
        <AdvancedModeSettings EnableDragAndDrop="true" EnableFileList="false" EnableMultiSelect="true" ExternalDropZoneID="externalDropZone"
            DropZoneText="" />
        <ValidationSettings MaxFileSize="4194304" AllowedFileExtensions=".aif,.cda,.midi,.mp3,.mpa,.ogg,.wav,.wma,.wpl,.7z ,.arj,.deb,.pkg,.rar,.rpm,.tar,.gz,.zip,.csv,.dat,.dbf ,.log,.mdb,.sav,.sql,.tar,.xml,.fnt,.fon,.otf,.ttf,.ai ,.bmp,.gif,.ico,.jpe, .jpg,.png,.ps ,.psd,.svg,.tiff,.key,.odp,.pps,.ppt,.pptx,.pptm,.ods,.xlr,.xls,.xlsx,.xlsm,.3g2,.3gp,.avi,.flv,.h26,.m4v,.mkv,.mov,.mp4,.mpg,.rm ,.swf,.vob,.wmv,.doc,docx,.odt,.pdf,.rtf,.tex,.txt,.wks,.wpd,.wps,.dot,.docm" ErrorStyle-CssClass="validationMessage" />
        <BrowseButton Text="Dodaj dokument..." />
        <DropZoneStyle CssClass="uploadControlDropZone" />
        <ProgressBarStyle CssClass="uploadControlProgressBar" />
        <ClientSideEvents
            DropZoneEnter="OnDropZoneEnter"
            DropZoneLeave="OnDropZoneLeave"
            FileUploadComplete="onUploadControlFileUploadComplete"></ClientSideEvents>
    </dx:ASPxUploadControl>
    <dx:ASPxCallback ID="CallbackUploadControl" runat="server" ClientInstanceName="clientCallbackUploadControl"
        OnCallback="CallbackUploadControl_Callback">
    </dx:ASPxCallback>
</div>
<div id="documentContainer" runat="server" class="container container-doc"></div>
