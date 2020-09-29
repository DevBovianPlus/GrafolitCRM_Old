<%@ Page Language="C#" MasterPageFile="~/PopUpMaster.Master" AutoEventWireup="true" CodeBehind="Prijava_popup.aspx.cs" Inherits="AnalizaProdaje.Prijava_popup" %>

<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>



<%@ Register Assembly="DevExpress.Xpo.v19.2, Version=19.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Xpo" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Xpo.v19.2, Version=19.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Xpo" TagPrefix="dx" %>



<asp:Content ID="HeadForJavaScript" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function ClearErrorTxt(s, e) {
            clientTxtLabel.SetText("");
            $('#ctl00_MainContentPlaceHolderPopUp_ErrorTableRow').css("display", "none");
            $('#ctl00_MainContentPlaceHolderPopUp_signInBtnWrap').css("margin-top", "10px");
        }

        function CauseValidation(s, e) {
            var procees = false;
            var inputItems = [clientUsername, clientPass];

            procees = InputFieldsValidation(null, inputItems, null, null);

            if (procees)
            {
                clientLoadingPanel.Show();
                e.processOnServer = true;
            }
            else
                e.processOnServer = false;
        }

        function FillPass(s, e) {
            var p = getCookie('UserPass');

            if (p != "") {
                clientPass.SetText(p);
                clientRememberMe.SetChecked(true);
            }
        }
    </script>
</asp:Content>


<asp:Content ID="MainContent" ContentPlaceHolderID="MainContentPlaceHolderPopUp" runat="server">
    <div class="section group">
        <div class="col popup span_2_of_2 no-margin-left-important" runat="server" id="ErrorTableRow">
            <div class="content-field-full-width">
                <dx:ASPxLabel ID="txtError" runat="server" Text="" Width="100%" ClientInstanceName="clientTxtLabel" ForeColor="Red"
                    Font-Size="Small">
                </dx:ASPxLabel>
            </div>
        </div>
        <div class="col popup span_2_of_2 no-margin-left-important">
            <div class="content-form-element-label-flex lable-width-large">
                <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="UPORABNIK :">
                </dx:ASPxLabel>
            </div>
            <div class="content-input-filed">
                <dx:ASPxTextBox ID="VnosUporabnik" runat="server" Width="300px" MaxLength="50" Theme="MetropolisBlue"
                    HorizontalAlign="Left" AutoCompleteType="Enabled" Font-Size="Small" CssClass="text-box-input"
                    ClientInstanceName="clientUsername">
                    <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                    <ValidationSettings ValidationGroup="Potrdi" Display="Static" ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                        <%--<RequiredField IsRequired="true" />--%>
                    </ValidationSettings>
                    <ClientSideEvents GotFocus="ClearErrorTxt" />
                </dx:ASPxTextBox>
            </div>
        </div>
        <div class="col popup span_2_of_2 no-margin-left-important">
            <div class="content-form-element-label-flex lable-width-large">
                <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="GESLO :">
                </dx:ASPxLabel>
            </div>
            <div class="content-input-filed">
                <dx:ASPxTextBox ID="VnosGeslo" runat="server" Width="300px" MaxLength="50" Theme="MetropolisBlue"
                    HorizontalAlign="Left" AutoCompleteType="Disabled" Password="true" Font-Size="Small" CssClass="text-box-input"
                    ClientInstanceName="clientPass">
                    <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                    <ValidationSettings ValidationGroup="Potrdi" Display="Static" ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true">
                        <%--<RequiredField IsRequired="true" />--%>
                    </ValidationSettings>
                    <ClientSideEvents GotFocus="ClearErrorTxt" Init="FillPass" />
                </dx:ASPxTextBox>
            </div>
        </div>        
        <div class="col popup span_2_of_2 no-margin-left-important">
            <div class="content-field-full-width">
                <dx:ASPxCheckBox runat="server" ID="RememberMe" Text="Zapomni si geslo" TextAlign="Left" Native="true" Font-Size="Small"
                    ClientInstanceName="clientRememberMe"></dx:ASPxCheckBox>
            </div>
        </div>
    </div>
    <div>
        <dx:ASPxLoadingPanel runat="server" ID="LoadingPanel" ClientInstanceName="clientLoadingPanel" Modal="true">
        </dx:ASPxLoadingPanel>
    </div>
    <div style="display: block; float: right; margin-top:0" id="signInBtnWrap" runat="server">
        <div style="float: left; width: 95px;">
            <dx:ASPxButton ID="ASPxButton1_Potrdi" runat="server" OnClick="ASPxButton_Potrdi"
                Text="Potrdi" Theme="MetropolisBlue" AutoPostBack="false" ValidationGroup="Potrdi" Width="90"
                Border-BorderColor="#596c7c" HoverStyle-BackColor="#0072C6">
                <ClientSideEvents Click="CauseValidation" />
            </dx:ASPxButton>
        </div>
        <div style="float: left; width: 100px;">
            <dx:ASPxButton ID="ASPxButton_preklici" runat="server" Text="Prekliči" Theme="MetropolisBlue"
                AutoPostBack="false" OnClick="ASPxButton_Preklici" Width="90"
                Border-BorderColor="#596c7c" HoverStyle-BackColor="#0072C6">
            </dx:ASPxButton>
        </div>
    </div>
</asp:Content>


