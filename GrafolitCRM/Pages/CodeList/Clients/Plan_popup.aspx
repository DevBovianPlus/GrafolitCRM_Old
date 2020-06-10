<%@ Page Language="C#" MasterPageFile="~/PopUpMaster.Master" AutoEventWireup="true" CodeBehind="Plan_popup.aspx.cs" Inherits="AnalizaProdaje.Pages.CodeList.Clients.Plan_popup" %>

<asp:Content ID="HeaderContent" ContentPlaceHolderID="head" runat="server">
    <script>

    </script>
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainContentPlaceHolderPopUp" runat="server">

    <dx:ASPxPageControl ID="ASPxPageControl1" runat="server" ActiveTabIndex="0" Theme="MetropolisBlue" Width="600px" Height="180px">
        <TabPages>
            <dx:TabPage Text="PODATKI">
                <ContentCollection>
                    <dx:ContentControl ID="ContentControl1" runat="server">
                        <table style="width: 100%;">
                            <tr>
                                <td>
                                    <span class="content-form-element-label">
                                        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="ID :"></dx:ASPxLabel>
                                    </span>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtPlanID" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                        ReadOnly="true" BackColor="LightGray">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                    </dx:ASPxTextBox>
                                </td>

                                <td style="float: right;">
                                    <span class="content-form-element-label">
                                        <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="ID STRANKE :"></dx:ASPxLabel>
                                    </span>
                                    <span class="content-form-input-right">
                                        <dx:ASPxTextBox ID="txtIdStranke" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                            ReadOnly="true" BackColor="LightGray">
                                            <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                        </dx:ASPxTextBox>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 1px; white-space: nowrap;">
                                    <span class="content-form-element-label">
                                        <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="KATEGORIJA :"></dx:ASPxLabel>
                                    </span>
                                </td>
                                <td>
                                    <span>
                                        <dx:ASPxComboBox ID="ComboBoxKategorije" runat="server" ValueType="System.String" DropDownStyle="DropDownList"
                                            IncrementalFilteringMode="StartsWith" TextField="Naziv" ValueField="idKategorija"
                                            EnableSynchronization="False" OnDataBinding="ComboBoxKategorije_DataBinding"
                                            Font-Size="Small" CssClass="text-box-input">
                                            <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                        </dx:ASPxComboBox>
                                    </span>
                                </td>
                                <td style="float: right;">
                                    <span class="content-form-element-label">
                                        <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="LETNI ZNESEK :"></dx:ASPxLabel>
                                    </span>
                                    <span class="content-form-input-right">
                                        <dx:ASPxTextBox ID="txtLetnoZnesek" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                            MaxLength="20">
                                            <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                            <ValidationSettings ValidationGroup="Confirm" Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true"
                                                RequiredField-ErrorText="Enter valid value">
                                                <RequiredField IsRequired="true" />
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="content-form-element-label">
                                        <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="LETO :"></dx:ASPxLabel>
                                    </span>
                                </td>
                                <td>
                                    <span>
                                        <dx:ASPxTextBox ID="txtLeto" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                            MaxLength="10">
                                            <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                        </dx:ASPxTextBox>
                                    </span>
                                </td>
                            </tr>
                        </table>
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
