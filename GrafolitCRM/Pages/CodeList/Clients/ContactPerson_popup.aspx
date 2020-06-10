<%@ Page Language="C#" MasterPageFile="~/PopUpMaster.Master" AutoEventWireup="true" CodeBehind="ContactPerson_popup.aspx.cs" Inherits="AnalizaProdaje.Pages.CodeList.Clients.ContactPerson_popup" %>

<asp:Content ID="HeaderContent" ContentPlaceHolderID="head" runat="server">
    <script>
        function CauseValidation(s, e) {
            var procees = false;
            var inputItems = [clientTxtNaziv];

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
                        <div class="section group smallLabelWidth">
                            <div class="col span_1_of_2 hide-block-important">
                                <span class="content-form-element-label">
                                    <dx:ASPxLabel ID="ASPxLabel11" runat="server" Text="ID :"></dx:ASPxLabel>
                                </span>
                                <dx:ASPxTextBox ID="txtContactPersonID" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                    ReadOnly="true" BackColor="LightGray">
                                    <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                </dx:ASPxTextBox>
                            </div>
                            <div class="col span_1_of_2 hide-block-important">
                                <span class="content-form-element-label">
                                    <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="ID STRANKE :"></dx:ASPxLabel>
                                </span>
                                <span class="content-form-input-right">
                                    <dx:ASPxTextBox ID="txtIdStranke" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                        ReadOnly="true" BackColor="LightGray">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                    </dx:ASPxTextBox>
                                </span>
                            </div>
                            <div class="col span_1_of_2 no-margin-left-important">
                                <div class="content-form-element-label-flex lable-width-large">
                                    <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="NAZIV :"></dx:ASPxLabel>
                                </div>
                                <div class="content-input-filed">
                                    <dx:ASPxTextBox ID="txtNaziv" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                        MaxLength="50" ClientInstanceName="clientTxtNaziv">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                        <ValidationSettings ValidationGroup="Confirm" Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true"
                                            RequiredField-ErrorText="Enter valid value" ErrorFrameStyle-Paddings-PaddingRight="0">
                                        </ValidationSettings>
                                        <ClientSideEvents Init="SetFocus" />
                                    </dx:ASPxTextBox>
                                </div>
                            </div>
                            <div class="col span_1_of_2 align_right_column_content">
                                <div class="content-form-element-label-flex lable-width-large">
                                    <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="TELEFON :"></dx:ASPxLabel>
                                </div>
                                <div class="content-input-filed">
                                    <dx:ASPxTextBox ID="txtTelefon" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                        MaxLength="50">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                    </dx:ASPxTextBox>
                                </div>
                            </div>
                            <div class="col span_1_of_2 no-margin-left-important">
                                <div class="content-form-element-label-flex lable-width-large">
                                    <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="GSM :"></dx:ASPxLabel>
                                </div>
                                <div class="content-input-filed">
                                    <dx:ASPxTextBox ID="txtGSM" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                        MaxLength="50">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                    </dx:ASPxTextBox>
                                </div>
                            </div>
                            <div class="col span_1_of_2 align_right_column_content">
                                <div class="content-form-element-label-flex lable-width-large">
                                    <dx:ASPxLabel ID="ASPxLabel9" runat="server" Text="FAX :"></dx:ASPxLabel>
                                </div>
                                <div class="content-input-filed">
                                    <dx:ASPxTextBox ID="txtFax" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                        MaxLength="30">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                    </dx:ASPxTextBox>
                                </div>
                            </div>
                            <div class="col span_1_of_2 no-margin-left-important">
                                <div class="content-form-element-label-flex lable-width-large">
                                    <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="EMAIL :"></dx:ASPxLabel>
                                </div>
                                <div class="content-input-filed">
                                    <dx:ASPxTextBox ID="txtEmail" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                        MaxLength="50">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                    </dx:ASPxTextBox>
                                </div>
                            </div>
                            <div class="col span_1_of_2 align_right_column_content">
                                <div class="content-form-element-label-flex lable-width-large">
                                    <dx:ASPxLabel ID="ASPxLabel7" runat="server" Text="DELOVNO MESTO :"></dx:ASPxLabel>
                                </div>
                                <div class="content-input-filed">
                                    <dx:ASPxTextBox ID="txtDelovnoMesto" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                        MaxLength="50">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                    </dx:ASPxTextBox>
                                </div>
                            </div>
                            <div class="col span_1_of_2 no-margin-left-important">
                                <div class="content-form-element-label-flex lable-width-large">
                                    <dx:ASPxLabel ID="ASPxLabel8" runat="server" Text="ZAP. ŠTEV. :"></dx:ASPxLabel>
                                </div>
                                <div class="content-input-filed">
                                    <dx:ASPxTextBox ID="txtZaporednaStevilka" runat="server" Width="170px" Font-Size="Small"
                                        CssClass="text-box-input">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                    </dx:ASPxTextBox>
                                </div>
                            </div>
                            <div class="col span_2_of_2 no-margin-left-important">
                                <div class="content-form-element-label-flex label-width-medium-popup">
                                    <dx:ASPxLabel ID="ASPxLabel10" runat="server" Text="OPOMBE :"></dx:ASPxLabel>
                                </div>
                                <div class="content-field-full-width">
                                    <dx:ASPxMemo ID="ASPxMemoZaznamki" runat="server" Width="100%" MaxLength="3000" Theme="Moderno"
                                        NullText="Zaznamki..." Rows="8" HorizontalAlign="Left" BackColor="White"
                                        CssClass="text-box-input">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                    </dx:ASPxMemo>
                                </div>
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
