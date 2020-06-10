<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserControlGraph.ascx.cs" Inherits="AnalizaProdaje.UserControls.UserControlGraph" %>
<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
 <link href="../../../Styles/Content.css" rel="stylesheet" />
<script type="text/javascript">
    var currentPeriod = "";
    var currentType = "";
    $(document).ready(function () {
        //currentPeriod = radioButtonsPeriod.GetSelectedIndex();
        //currentType = radioButtonsType.GetSelectedIndex();
        //clientBtnRenderGraph.SetEnabled(false);
        //clientBtnRenderGraph.enabled = false;
        function Click() {
            alert("test");
            var url = "WebForm1.aspx?points=" + $("#txtName").val() + "&lineColor=" + $("#txtLineColor").val();
            window.location.href = url;
        }

        $("#btnQueryString").click(function () {
            alert("test");
            var url = "WebForm1.aspx?points=" + $("#txtName").val() + "&lineColor=" + $("#txtLineColor").val();
            window.location.href = url;
        });

        //setInterval(ValuecheckedChanged, 500);

        var value = hfUSCRadioButtonDisabled.Get("RadioButtonUSCDisabled");
        if (value != null && value) {
            radioButtonsPeriod.SetEnabled(true);
        }
        else if (value != null && !value) {
            radioButtonsPeriod.SetEnabled(false);
        }
    });


    function ValueCheckedChanged(s, e) {
        /*var nameSplit = s.name.split('_');
        var name = nameSplit[nameSplit.length - 1];
        var newSelectedPeriod = radioButtonsPeriod.GetSelectedIndex();
        var newSelectedType = radioButtonsType.GetSelectedIndex();

        if (name == "rbPeriod")
            newSelectedPeriod = s.GetSelectedIndex();
        else
            newSelectedType = s.GetSelectedIndex();

        if (currentPeriod != newSelectedPeriod || currentType != newSelectedType) {
            clientBtnRenderGraph.SetEnabled(true);
            currentPeriod = newSelectedPeriod;
            currentType = newSelectedType;

        }
        else {
            clientBtnRenderGraph.SetEnabled(false);
        }*/
    }

    function OnDateChanged_UserCotrol_DO(s, e) {
        var date = clientUserControlDateEdit_DO.GetDate();
        if (date != null) {
            radioButtonsPeriod.SetEnabled(false);
            hfUSCRadioButtonDisabled.Set("RadioButtonUSCDisabled", false);
            //clientRBLTypeDetail.SetSelectedItem(null);
        }
        else {
            radioButtonsPeriod.SetEnabled(true);
            hfUSCRadioButtonDisabled.Set("RadioButtonUSCDisabled", true);
        }
    }

</script>

<%--<dx:ASPxButton ID="btnDeleteGraph" runat="server" Text="Izbrisi graf" OnClick="btnDeleteGraph_Click" AutoPostBack="false">
    <%--<ClientSideEvents Click="function (s, e) { callbackClient.PerformCallback(); }" />
</dx:ASPxButton>--%>

<table style="width: 100%">
    <tr>
        <td>
            <div style="display: block; text-align: center;">
                <dx:ASPxHeadline runat="server" Theme="Moderno" ID="ChartHeaderName">
                    <HeaderStyle HorizontalAlign="Center" />
                </dx:ASPxHeadline>
                <dx:ASPxHyperLink runat="server" Theme="Moderno" ID="ChartHyperLink" Text="Podrobno">
                </dx:ASPxHyperLink>
            </div>
        </td>
    </tr>
    <tr>
        <td style="padding: 0; margin: 0;">
            <div style="display: flex;">
                <div class="float-left flex-box-vertical-align">
                    <dx:ASPxRadioButtonList runat="server" Caption="Obdobje" RepeatColumns="3" ID="rbPeriod"
                        ClientInstanceName="radioButtonsPeriod" Paddings-Padding="0">
                        <Paddings Padding="0" />
                        <CaptionSettings Position="Top" />
                        <Items>
                            <dx:ListEditItem Text="Mesečno" Value="1" />
                            <dx:ListEditItem Text="Letno" Value="2" />
                            <dx:ListEditItem Text="Tedensko" Value="3" />
                        </Items>
                        <%--<ClientSideEvents SelectedIndexChanged="ValueCheckedChanged" />--%>
                    </dx:ASPxRadioButtonList>
                </div>
                <div class="initial-hide-block float-left medium-margin-l large-margin-top" id="filteringFromToDateBlock" runat="server">
                    <div class="float-left medium-margin-l flex-box-vertical-align">
                        <dx:ASPxDateEdit Theme="MetropolisBlue" ID="UserControlDateEdit_OD" runat="server" Caption="Od " EditFormat="Date"
                            Width="100">
                            <CaptionSettings VerticalAlign="Middle" />
                            <CalendarProperties TodayButtonText="Danes" ClearButtonText="Izbriši"></CalendarProperties>
                            <DropDownButton Visible="true"></DropDownButton>
                        </dx:ASPxDateEdit>

                    </div>
                    <div class="float-left small-margin-l flex-box-vertical-align small-margin-r">
                        <dx:ASPxDateEdit Theme="MetropolisBlue" ID="UserControlDateEdit_DO" runat="server" Caption="Do " EditFormat="Date"
                            Width="100" ClientInstanceName="clientUserControlDateEdit_DO">
                            <CaptionSettings VerticalAlign="Middle" />
                            <ClientSideEvents DateChanged="OnDateChanged_UserCotrol_DO" />
                            <CalendarProperties TodayButtonText="Danes" ClearButtonText="Izbriši"></CalendarProperties>
                            <DropDownButton Visible="true"></DropDownButton>
                        </dx:ASPxDateEdit>
                        <dx:ASPxHiddenField runat="server" ClientInstanceName="hfUSCRadioButtonDisabled" ID="hfUSCRadioButtonDisabled">
                        </dx:ASPxHiddenField>
                    </div>
                </div>
            </div>
        </td>
    </tr>
    <tr>
        <td style="padding: 0; margin: 0;">
            <div style="display: block;">
                <dx:ASPxRadioButtonList runat="server" Caption="Tip" RepeatColumns="4" ID="rbType"
                    ClientInstanceName="radioButtonsType" RepeatLayout="Table">
                    <Paddings Padding="0" />
                    <CaptionSettings Position="Top" />
                    <Items>
                        <dx:ListEditItem Text="Prodaja" Value="1" />
                        <dx:ListEditItem Text="Količina" Value="2" />
                        <dx:ListEditItem Text="RVC" Value="3" />
                        <dx:ListEditItem Text="RVC (%)" Value="4" />
                    </Items>
                    <%-- <ClientSideEvents SelectedIndexChanged="ValueCheckedChanged" />--%>
                </dx:ASPxRadioButtonList>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div style="display: block; text-align: left">
                <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Izrisi graf" OnClick="ASPxButton1_Click"
                    ClientInstanceName="clientBtnRenderGraph">
                    <Image Url="/Images/DrawChart.png" Width="28px"></Image>
                </dx:ASPxButton>
            </div>
        </td>
    </tr>
    <%--<tr>
        <td>
            <div style="display: block; text-align: left">
                <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Izrisi graf" ClientInstanceName="clientBtnRenderGraph" AutoPostBack="false">
                    <ClientSideEvents Click="function(s,e){ chart.Print();}" />
                </dx:ASPxButton>
            </div>
        </td>
    </tr>--%>
    <tr>
        <td>
            <dx:WebChartControl ID="WebChartControl1" runat="server" Width="100px" Height="150px" Visible="false" ClientInstanceName="chart"
                EnableClientSideAPI="true">
            </dx:WebChartControl>
        </td>
    </tr>
    <tr>
        <td>
            <div style="display: block; float: left; overflow: hidden" id="EventLinkWrap" runat="server"></div>
        </td>
    </tr>
    <tr>
        <td>
            <div style="display: block; text-align: left;">
                <dx:ASPxButton ID="addEventBtn" runat="server" AutoPostBack="False" AllowFocus="False"
                    Text="Dodaj dogodek" OnClick="addEventBtn_Click">
                    <Image Url="/Images/addEventBtn.png" UrlHottracked="/Images/addEventBtnPressed.png">
                        <%--<SpriteProperties CssClass="addEvent" HottrackedCssClass="addEventHottracked" PressedCssClass="addEventPressed" />--%>
                    </Image>
                </dx:ASPxButton>
            </div>
        </td>
    </tr>
</table>


<%--<dx:ASPxTextBox ID="ASPxTextBox1" runat="server" Width="170px" ReadOnly="true" BackColor="LightGray" ClientInstanceName="txtKomercialisti"></dx:ASPxTextBox>--%>

<%--<hr />--%>
<%--<script type="text/javascript" src="../Scripts/ChromeFix_14.js"></script>--%>
