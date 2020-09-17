<%@ Page Language="C#" MasterPageFile="~/MasterPage.Master" Title="Urejanje profila" AutoEventWireup="true" CodeBehind="MailTest.aspx.cs" Inherits="AnalizaProdaje.Pages.Testing.MailTest" %>

<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="HeadForJavaScript" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $("#ctl00_ContentPlaceHolder2_ASPxRoundPanel1_clearImage").on("click", function () {
                clientClearImageCallback.PerformCallback();
            });

        });

        function CauseValidation(s, e) {
            var inputItems = [txtHostClient, txtPortClient, txtMailToClient, txtSubjectClient, txtSenderClient];

            var procees = InputFieldsValidation(null, inputItems, null);

            if (procees) {
                LoadingPanelClient.Show();
                SendCallbackClient.PerformCallback("Test");
            }
        }

        function EndCallBackClient(s, e) {
            LoadingPanelClient.Hide();
            if (s.cpMailSendError != null && s.cpMailSendError !== undefined) {
                ShowErrorPopUp(s.cpMailSendError, 0, "Opozorilo");
                delete (s.cpGeneratedLocation);
            }
        }

        function CheckChangedCredentials(s, e)
        {
            var value = s.GetChecked();

            if (value)
            {
                txtPasswordClient.SetEnabled(true);
                txtUsernameClient.SetEnabled(true);
            }
            else
            {
                txtPasswordClient.SetEnabled(false);
                txtUsernameClient.SetEnabled(false);
            }
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="container">
        <dx:ASPxLoadingPanel ID="LoadingPanel" runat="server" ClientInstanceName="LoadingPanelClient" Modal="false"></dx:ASPxLoadingPanel>
        <h3 style="text-align: center;">Testiranje pošiljanje elektronske pošte</h3>
        <div class="wrap">
            <div class="section group">
                <div class="col span_1_of_2 no-margin-left-important">
                    <div class="content-form-element-label-flex lable-width-large">
                        <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="HOST :"></dx:ASPxLabel>
                    </div>
                    <div class="content-field-full-width">
                        <dx:ASPxTextBox ID="txtHost" runat="server" Width="100%" Font-Size="Small" CssClass="text-box-input"
                            ClientInstanceName="txtHostClient" MaxLength="100">
                            <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                            <ClientSideEvents Init="SetFocus" />
                        </dx:ASPxTextBox>
                    </div>
                </div>
                <div class="col span_1_of_2 align_right_column_content">
                    <div class="content-form-element-label-flex">
                        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="PORT :"></dx:ASPxLabel>
                    </div>
                    <div class="content-input-filed">
                        <dx:ASPxTextBox ID="txtPort" runat="server" Width="100%" Font-Size="Small" CssClass="text-box-input"
                            ClientInstanceName="txtPortClient" MaxLength="100">
                            <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                        </dx:ASPxTextBox>
                    </div>
                </div>
                <div class="col span_1_of_2 no-margin-left-important">
                    <div class="content-form-element-label-flex lable-width-large">
                        <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="SSL :"></dx:ASPxLabel>
                    </div>
                    <div class="content-input-filed">
                        <dx:ASPxCheckBox ID="EnableSSLCheckBox" runat="server"></dx:ASPxCheckBox>
                    </div>
                </div>
                <div class="col span_1_of_2 align_right_column_content">
                    <div class="content-form-element-label-flex">
                        <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="CREDENTIALS EXIST :"></dx:ASPxLabel>
                    </div>
                    <div class="content-input-filed">
                        <dx:ASPxCheckBox ID="CredentialExistCheckBox" runat="server" ClientInstanceName="CredentialExistCheckBoxClient">
                            <ClientSideEvents ValueChanged="CheckChangedCredentials" />
                        </dx:ASPxCheckBox>
                    </div>
                </div>
                <div class="col span_1_of_2 no-margin-left-important">
                    <div class="content-form-element-label-flex lable-width-large">
                        <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="USERNAME :"></dx:ASPxLabel>
                    </div>
                    <div class="content-input-filed">
                        <dx:ASPxTextBox ID="txtUsername" runat="server" Width="100%" Font-Size="Small" CssClass="text-box-input"
                            ClientInstanceName="txtUsernameClient" MaxLength="50">
                            <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                        </dx:ASPxTextBox>
                    </div>
                </div>
                <div class="col span_1_of_2 align_right_column_content">
                    <div class="content-form-element-label-flex">
                        <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="PASSWORD :"></dx:ASPxLabel>
                    </div>
                    <div class="content-input-filed">
                        <dx:ASPxTextBox ID="txtPassword" runat="server" Width="100%" Font-Size="Small" CssClass="text-box-input"
                            ClientInstanceName="txtPasswordClient" MaxLength="50">
                            <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                        </dx:ASPxTextBox>
                    </div>
                </div>
                <div class="col span_1_of_2 no-margin-left-important">
                    <div class="content-form-element-label-flex lable-width-large">
                        <dx:ASPxLabel ID="ASPxLabel10" runat="server" Text="SENDER :"></dx:ASPxLabel>
                    </div>
                    <div class="content-input-filed">
                        <dx:ASPxTextBox ID="txtSender" runat="server" Width="100%" Font-Size="Small" CssClass="text-box-input"
                            ClientInstanceName="txtSenderClient" MaxLength="50">
                            <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                        </dx:ASPxTextBox>
                    </div>
                </div>
                <div class="col span_1_of_2 align_right_column_content">
                    <div class="content-form-element-label-flex">
                        <dx:ASPxLabel ID="ASPxLabel7" runat="server" Text="MAIL TO :"></dx:ASPxLabel>
                    </div>
                    <div class="content-input-filed">
                        <dx:ASPxTextBox ID="txtMailTo" runat="server" Width="100%" Font-Size="Small" CssClass="text-box-input"
                            ClientInstanceName="txtMailToClient" MaxLength="50">
                            <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                        </dx:ASPxTextBox>
                    </div>
                </div>
                <div class="col span_2_of_2 no-margin-left-important">
                    <div class="content-form-element-label-flex lable-width-large">
                        <dx:ASPxLabel ID="ASPxLabel8" runat="server" Text="SUBJECT :"></dx:ASPxLabel>
                    </div>
                    <div class="content-field-full-width">
                        <dx:ASPxTextBox ID="txtSubject" runat="server" Width="100%" Font-Size="Small" CssClass="text-box-input"
                            ClientInstanceName="txtSubjectClient" MaxLength="50">
                            <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                        </dx:ASPxTextBox>
                    </div>
                </div>
                <div class="col span_2_of_2 no-margin-left-important big-margin-b">
                    <div class="content-form-element-label-flex lable-width-large">
                        <dx:ASPxLabel ID="ASPxLabel9" runat="server" Text="BODY :"></dx:ASPxLabel>
                    </div>
                    <div class="content-field-full-width">
                        <dx:ASPxMemo ID="txtBody" runat="server" Width="100%" MaxLength="2000" Theme="Moderno"
                            NullText="Ime dogodka..." Rows="4" HorizontalAlign="Left" BackColor="White"
                            CssClass="text-box-input">
                            <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                        </dx:ASPxMemo>
                    </div>
                </div>
                <div class="col span_2_of_2 no-margin-left-important">
                    <dx:ASPxButton ID="btnSend" runat="server" Text="Send" AutoPostBack="false" UseSubmitBehavior="false">
                        <ClientSideEvents Click="CauseValidation" />
                    </dx:ASPxButton>
                    <dx:ASPxCallback ID="SendCallback" runat="server" OnCallback="SendCallback_Callback" ClientInstanceName="SendCallbackClient">
                        <ClientSideEvents EndCallback="EndCallBackClient" />
                    </dx:ASPxCallback>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
