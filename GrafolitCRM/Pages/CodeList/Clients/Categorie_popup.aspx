<%@ Page Language="C#" MasterPageFile="~/PopUpMaster.Master" AutoEventWireup="true" CodeBehind="Categorie_popup.aspx.cs" Inherits="AnalizaProdaje.Pages.CodeList.Clients.Categorie_popup" %>

<asp:Content ID="HeaderContent" ContentPlaceHolderID="head" runat="server">
    <script>

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
                                    <dx:ASPxTextBox ID="txtClientCategorieID" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
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
                                <div class="content-form-element-label-flex lable-width-medium">
                                    <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="KATEGORIJA :"></dx:ASPxLabel>
                                </div>
                                <div class="content-field-full-width">
                                    <dx:ASPxComboBox ID="ComboBoxKategorije" runat="server" ValueType="System.String" DropDownStyle="DropDownList"
                                        IncrementalFilteringMode="StartsWith" TextField="Naziv" ValueField="idKategorija"
                                        EnableSynchronization="False" OnDataBinding="ComboBoxKategorije_DataBinding"
                                        Font-Size="Small" CssClass="text-box-input" Width="250px">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                        <ValidationSettings ValidationGroup="Confirm" Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true"
                                            RequiredField-ErrorText="Enter valid value">
                                            <RequiredField IsRequired="true" />
                                        </ValidationSettings>
                                        <ClientSideEvents Init="SetFocus" />
                                    </dx:ASPxComboBox>
                                </div>
                            </div>
                            <%--<div class="col span_1_of_2 hide-block-important">
                                <div class="content-form-element-label-flex lable-width-medium">
                                    <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="LETNI ZNESEK :"></dx:ASPxLabel>
                                </div>
                                <div class="content-input-filed">
                                    <dx:ASPxTextBox ID="txtLetnoZnesek" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                        MaxLength="20">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                    </dx:ASPxTextBox>
                                </div>
                            </div>--%>
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
                                        ValidationGroup="Confirm">
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
