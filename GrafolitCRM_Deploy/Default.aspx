<%@ Page Language="C#" MasterPageFile="~/HelloMasterPage.Master" Title="Analiza Prodaje" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="AnalizaProdaje.Default" %>

<%@ MasterType VirtualPath="~/HelloMasterPage.master" %>

<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<%@ Register Src="~/UserControls/Widgets/DateTimeWidget.ascx" TagName="DateTime" TagPrefix="widget" %>
<%@ Register Src="~/UserControls/Widgets/CalendarWidget.ascx" TagName="Calander" TagPrefix="widget" %>

<asp:Content ID="HeadForJavaScript" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function OnClosePopupEventHandler_Prijava(param, url) {
            switch (param) {
                case 'Potrdi':
                    Prijava_Popup.Hide();
                    window.location.assign(url);//"../Default.aspx"
                    break;
                case 'Prekliči':
                    Prijava_Popup.Hide();
                    break;
            }
        }
        $(document).ready(function () {

        });

    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <dx:ASPxRoundPanel ID="ASPxRoundPanel1" ShowCollapseButton="false" runat="server" Theme="MetropolisBlue"
        HeaderStyle-HorizontalAlign="Center" Font-Bold="true" Width="100%" HeaderText="ANALIZA PRODAJE - PRIJAVA">
        <ContentPaddings PaddingBottom="7px" PaddingLeft="3px" PaddingRight="3px" PaddingTop="7px" />
        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
        <PanelCollection>
            <dx:PanelContent runat="server">
                <div class="login-btn-wrap">
                    <dx:ASPxButton ID="ASPxButtonLogin" runat="server" Text="PRIJAVA / LOGIN" AutoPostBack="false" CssClass="tile-btn" Font-Bold="true" ImagePosition="Top"
                        EncodeHtml="False" OnClick="ASPxButtonLogin_Click" Font-Size="Small" RenderMode="Button">
                        <HoverStyle BackColor="#00a0f2"></HoverStyle>
                    </dx:ASPxButton>
                    <dx:ASPxLabel ID="UspeloNiUspelo" runat="server" Text="" Font-Size="10px" Font-Bold="True" Font-Names="Verdana" ForeColor="#0072C6"
                        Height="12px">
                    </dx:ASPxLabel>
                </div>
                <div runat="server" class="flex-box-vertical-align" id="widgetSection">
                    <dx:ASPxDockPanel runat="server" ID="DateTimePanel" PanelUID="DateTime" HeaderText="Danes"
                        Left="820" Top="220" ClientInstanceName="dateTimePanel" Width="230px" Height="100px" ShowCloseButton="true"
                        OwnerZoneUID="RightZone">
                        <ContentCollection>
                            <dx:PopupControlContentControl>
                                <widget:DateTime ID="DateTimeWidget" runat="server" />
                            </dx:PopupControlContentControl>
                        </ContentCollection>
                    </dx:ASPxDockPanel>
                    <%--<dx:ASPxDockPanel runat="server" ID="CalanderPanel" PanelUID="Calander" HeaderText="Koledar"
                        Width="280px" OwnerZoneUID="LeftZone" VisibleIndex="0">
                        <ContentCollection>
                            <dx:PopupControlContentControl>
                                <widget:Calander ID="CalanderWidget" runat="server" />
                            </dx:PopupControlContentControl>
                        </ContentCollection>
                    </dx:ASPxDockPanel>--%>
                    <dx:ASPxDockPanel runat="server" ID="eventsWidgetPanel" ClientInstanceName="clientEventsWidgetPanel" PanelUID="eventsWidget"
                        OwnerZoneUID="RightZone" ShowCloseButton="false" Width="100%"
                        OnLoad="eventsWidgetPanel_Load" HeaderText="Prihajajoči dogodki">
                        <Styles>
                            <Content>
                                <Paddings PaddingLeft="17px" PaddingRight="17px" PaddingTop="13px" />
                            </Content>
                        </Styles>
                    </dx:ASPxDockPanel>
                    <dx:ASPxDockZone runat="server" ID="ASPxDockZone1" ZoneUID="LeftZone" CssClass="leftZone"
                        Width="50%" PanelSpacing="3" Visible="false">
                    </dx:ASPxDockZone>
                    <dx:ASPxDockZone runat="server" ID="ASPxDockZone2" ZoneUID="RightZone" CssClass="rightZone"
                        Width="50%" PanelSpacing="1">
                    </dx:ASPxDockZone>
                </div>
                <dx:ASPxPopupControl ID="ASPxPopupControl1_Prijava" runat="server" ContentUrl="Prijava_popup.aspx"
                    ClientInstanceName="Prijava_Popup" Modal="True" HeaderText="PRIJAVA" Theme="MetropolisBlue"
                    CloseAction="CloseButton" Width="430px" MaxHeight="240px" PopupHorizontalAlign="WindowCenter"
                    PopupVerticalAlign="WindowCenter" PopupAnimationType="Fade" AllowDragging="true" ShowSizeGrip="true"
                    PopupElementID="popupPrijava" AllowResize="true">
                    <ContentStyle BackColor="#F7F7F7">
                        <Paddings PaddingBottom="0px" PaddingLeft="0px" PaddingRight="0px" PaddingTop="0px"></Paddings>
                    </ContentStyle>
                    <ContentCollection>
                        <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                        </dx:PopupControlContentControl>
                    </ContentCollection>
                </dx:ASPxPopupControl>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxRoundPanel>
</asp:Content>
