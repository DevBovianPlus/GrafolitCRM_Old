<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DateTimeWidget.ascx.cs" Inherits="AnalizaProdaje.UserControls.Widgets.DateTimeWidget" %>
<script type="text/javascript">
    function PrepareTimeValue(value) {
        if (value < 10)
            value = "0" + value;
        return value;
    }
    function UpdateTime(s, e) {
        var dateTime = new Date();
        var timeString = PrepareTimeValue(dateTime.getHours()) + ":" + PrepareTimeValue(dateTime.getMinutes()) + ":" +
            PrepareTimeValue(dateTime.getSeconds());
        timeLabel.SetText(timeString);
    }
</script>
<div class="alignCenter">
    <div>
        <dx:ASPxTimer runat="server" ID="Timer" ClientInstanceName="timer" Interval="1000">
            <ClientSideEvents Init="UpdateTime" Tick="UpdateTime" />
        </dx:ASPxTimer>
        <dx:ASPxLabel runat="server" ID="TimeLabel" ClientInstanceName="timeLabel" Font-Bold="true"
            Font-Size="X-Large">
        </dx:ASPxLabel>
    </div>
    <div>
        <dx:ASPxLabel runat="server" ID="DateLabel" ClientInstanceName="dateLabel" Font-Size="14px">
        </dx:ASPxLabel>
    </div>
</div>
