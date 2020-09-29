<%@ Page Language="C#" MasterPageFile="~/MasterPage.Master" Title="AnalizaProdaje - NAPAKA" AutoEventWireup="true" CodeBehind="ErrorPage.aspx.cs" Inherits="AnalizaProdaje.Pages.Error.ErrorPage" %>

<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="HeadForJavaScript" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">

    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <dx:ASPxRoundPanel ID="ASPxRoundPanel1" ShowCollapseButton="false" runat="server" Theme="MetropolisBlue"
        HeaderStyle-HorizontalAlign="Center" Font-Bold="true" Width="100%" HeaderText="NAPAKA V ANALIZI PRODAJE">
        <ContentPaddings PaddingBottom="7px" PaddingLeft="3px" PaddingRight="3px" PaddingTop="7px" />
        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
        <PanelCollection>
            <dx:PanelContent runat="server">
                <div class="flex-box-vertical-align">
                    <img src="../../../Images/Smile.png" width="50"/>
                </div>
                <h1>ERROR</h1>
                <p>V aplikaciji se je zgodila nevšečna napaka. Naša ekipa razvijalcev je že dobila obvestilo o napaki, ki se je zgodila in je v čakalni vrsti za odpravljanje. Za to se vam iskreno opravičujemo in vas pozdravljamo.</p>
                <div class="float-left">
                    <span class="AddEditButtons no-margin-top">
                        <dx:ASPxButton ID="btnGoBack" runat="server" Text="Pojdi nazaj" AutoPostBack="false" GroupName="CG"
                            Height="30" Width="100" CheckedStyle-CssClass="" OnClick="btnGoBack_Click" Visible="false">
                            <Image Url="../../../Images/ErrorBackBtn.png"></Image>
                        </dx:ASPxButton>
                    </span>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxRoundPanel>
</asp:Content>
