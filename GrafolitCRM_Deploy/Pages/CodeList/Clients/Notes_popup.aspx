<%@ Page Language="C#" MasterPageFile="~/PopUpMaster.Master" AutoEventWireup="true" CodeBehind="Notes_popup.aspx.cs" Inherits="AnalizaProdaje.Pages.CodeList.Clients.Notes_popup" %>

<asp:Content ID="HeaderContent" ContentPlaceHolderID="head" runat="server">
    <script>
        //function FillNotesCodeInput(s, e) {
        //    if (clientNotesCode.GetText().length < 4) {
        //        var currentText = clientNotesCode.GetText();

        //    }
        //}
        //function FillNotesCodeInput(s, e) {
        //    if (clientNotesCode.GetText().length <= 0) {
        //        var currentText = clientNotesName.GetText();
        //        var len = currentText.length;
        //        if (currentText.length >= 3) {
        //            var code = currentText.substring(0, 3).toUpperCase();
        //            code = CheckForSpecialCharacters(code);
        //            //code += "00";
        //            clientNotesCode.SetText(code);
        //        }
        //    }

        //}

        function CauseValidation(s, e) {
            var procees = false;
            var inputItems = null;

            if (clientBtnConfirm.GetText() == 'Izbrisi')
                procees = true;
            else
                procees = InputFieldsValidation(null, inputItems, null, null);

            if (procees)
                e.processOnServer = true;
            else
                e.processOnServer = false;
        }
    </script>
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainContentPlaceHolderPopUp" runat="server">

    <dx:ASPxPageControl ID="ASPxPageControl1" runat="server" ActiveTabIndex="0" Theme="MetropolisBlue" Width="100%">
        <TabPages>
            <dx:TabPage Text="PODATKI">
                <ContentCollection>
                    <dx:ContentControl ID="ContentControl1" runat="server">
                        <div class="section group">
                            <div class="col span_1_of_2 hide-block-important">
                                <div class="content-form-element-label-flex lable-width-medium">
                                    <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="ID :"></dx:ASPxLabel>
                                </div>
                                <div class="content-input-filed">
                                    <dx:ASPxTextBox ID="txtNotesID" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                        ReadOnly="true" BackColor="LightGray">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                    </dx:ASPxTextBox>
                                </div>
                            </div>
                            <div class="col span_1_of_2 hide-block-important">
                                <div class="content-form-element-label-flex lable-width-medium">
                                    <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="ID STRANKE :"></dx:ASPxLabel>
                                </div>
                                <div class="content-input-filed">
                                    <dx:ASPxTextBox ID="txtIdStranke" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                        ReadOnly="true" BackColor="LightGray">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                    </dx:ASPxTextBox>
                                </div>
                            </div>

                            <div class="col span_2_of_2">
                                <dx:ASPxHtmlEditor ID="htmlOpomba" runat="server" Width="100%" CssClass="text-box-input">
                                    <SettingsValidation>
                                        <RequiredField IsRequired="True" />
                                    </SettingsValidation>
                                </dx:ASPxHtmlEditor>
                            </div>

                        </div>
                        <div class="AddEditButtonsWrap">
                            <div class="AddEditButtonsElements" style="margin-top: 10px;">
                                <span class="AddEditButtons">
                                    <dx:ASPxButton ID="btnCancelPopUp" runat="server" Text="Prekliči" OnClick="btnCancelPopUp_Click" AutoPostBack="false"
                                        Height="20" Width="80">
                                        <Image Url="../../../Images/cancelPopUp.png"></Image>
                                    </dx:ASPxButton>
                                </span>
                                <span class="AddEditButtons">
                                    <dx:ASPxButton ID="btnConfirmPopUp" runat="server" Text="Potrdi" OnClick="btnConfirmPopUp_Click" AutoPostBack="false"
                                        ValidationGroup="Confirm" ClientInstanceName="clientBtnConfirm">
                                        <ClientSideEvents Click="CauseValidation" />
                                    </dx:ASPxButton>
                                </span>
                            </div>
                        </div>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
        </TabPages>
    </dx:ASPxPageControl>
    <%--<script type="text/javascript" src="../../../Scripts/ChromeFix_14.js"></script>--%>
</asp:Content>
