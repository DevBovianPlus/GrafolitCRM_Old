<%@ Page Language="C#" MasterPageFile="~/PopUpMaster.Master" AutoEventWireup="true" CodeBehind="ReportError_popup.aspx.cs" Inherits="AnalizaProdaje.Pages.Error.ReportError_popup" %>

<asp:Content ID="HeaderContent" ContentPlaceHolderID="head" runat="server">
    <script>
        function CauseValidation(s, e) {
            var procees = false;
            var memoItems = [memoOpis];           

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
            <dx:TabPage Text="E-MAIL">
                <ContentCollection>
                    <dx:ContentControl ID="ContentControl1" runat="server">
                        <div class="section group">
                            <div class="col span_2_of_2">
                                <div class="content-form-element-label-flex lable-width-medium">
                                    <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="ZADEVA :"></dx:ASPxLabel>
                                </div>
                                <div class="content-input-filed">
                                    <dx:ASPxTextBox ID="txtEmailZadeva" runat="server" Width="300px" Font-Size="Small" CssClass="text-box-input">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                        <ClientSideEvents Init="SetFocus" />
                                    </dx:ASPxTextBox>
                                </div>
                            </div>
                            <div class="col span_2_of_2">
                                <div class="content-form-element-label-flex lable-width-medium">
                                    <dx:ASPxLabel ID="ASPxLabel9" runat="server" Text="OPIS :"></dx:ASPxLabel>
                                </div>
                                <div class="content-field-full-width">
                                    <dx:ASPxMemo ID="ASPxMemoOpis" runat="server" Width="100%" MaxLength="2000" Theme="Moderno"
                                        NullText="Opis napake, ki ste jo zaznali..." Rows="8" HorizontalAlign="Left" BackColor="White"
                                        CssClass="text-box-input" ClientInstanceName="memoOpis">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                        <ValidationSettings ValidationGroup="Confirm" Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true"
                                            RequiredField-ErrorText="Enter valid value">
                                        </ValidationSettings>
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
                                    <dx:ASPxButton ID="btnConfirmPopUp" runat="server" Text="Pošlji" OnClick="btnConfirmPopUp_Click" AutoPostBack="false"
                                        ValidationGroup="Confirm" ClientInstanceName="clientBtnConfirm">
                                         <Image Url="../../../Images/inboxDoc.png"></Image>
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
