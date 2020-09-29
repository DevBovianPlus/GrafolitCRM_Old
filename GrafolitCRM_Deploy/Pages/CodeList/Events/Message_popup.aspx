<%@ Page Language="C#" MasterPageFile="~/PopUpMaster.Master" AutoEventWireup="true" CodeBehind="Message_popup.aspx.cs" Inherits="AnalizaProdaje.Pages.CodeList.Events.Message_popup" %>

<asp:Content ID="HeaderContent" ContentPlaceHolderID="head" runat="server">
    <script>
        function CauseValidation(s, e) {
            var procees = false;
            var memoItems = [memoOpis];           

            if (clientBtnConfirm.GetText() == 'Izbrisi')
                procees = true;
            else
                procees = InputFieldsValidation(null, null, null, memoItems);

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
                                    <dx:ASPxTextBox ID="txtSporociloID" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                        ReadOnly="true" BackColor="LightGray">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                    </dx:ASPxTextBox>
                                </div>
                            </div>
                            <div class="col span_1_of_2 hide-block-important">
                                <div class="content-form-element-label-flex lable-width-medium">
                                    <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="ID DOGODEK :"></dx:ASPxLabel>
                                </div>
                                <div class="content-input-filed">
                                    <dx:ASPxTextBox ID="txtIdDogodek" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                        ReadOnly="true" BackColor="LightGray">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                    </dx:ASPxTextBox>
                                </div>
                            </div>
                            <div class="col span_2_of_2">
                                <div class="content-form-element-label-flex lable-width-medium">
                                    <dx:ASPxLabel ID="ASPxLabel9" runat="server" Text="OPIS :"></dx:ASPxLabel>
                                </div>
                                <div class="content-field-full-width">
                                    <dx:ASPxMemo ID="ASPxMemoOpis" runat="server" Width="100%" MaxLength="2000" Theme="Moderno"
                                        NullText="Opis sporočila..." Rows="8" HorizontalAlign="Left" BackColor="White"
                                        CssClass="text-box-input" ClientInstanceName="memoOpis">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                        <ValidationSettings ValidationGroup="Confirm" Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true"
                                            RequiredField-ErrorText="Enter valid value">
                                        </ValidationSettings>
                                        <ClientSideEvents Init="SetFocus" />
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
