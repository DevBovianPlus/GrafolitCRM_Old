<%@ Page Language="C#" MasterPageFile="~/PopUpMaster.Master" Title="Urejanje zaposlenih" AutoEventWireup="true" CodeBehind="Employee_popup.aspx.cs" Inherits="AnalizaProdaje.Pages.CodeList.Employees.Employee_popup" %>

<asp:Content ID="HeaderContent" ContentPlaceHolderID="head" runat="server">
    <script>

    </script>
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainContentPlaceHolderPopUp" runat="server">
    <%--Width="630px" Height="270px"  --%>
    <dx:ASPxPageControl ID="ASPxPageControl1" runat="server" ActiveTabIndex="0" Theme="MetropolisBlue" Width="100%">
        <TabPages>
            <dx:TabPage Name="BasicData" Text="OSNOVNI PODATKI">
                <ContentCollection>
                    <dx:ContentControl ID="ContentControl1" runat="server">
                        <div class="section group">
                            <div class="col span_1_of_2 hide-block-important">
                                <div class="content-form-element-label-flex lable-width-medium">
                                    <dx:ASPxLabel ID="ASPxLabel102" runat="server" Text="ID :"></dx:ASPxLabel>
                                </div>
                                <div class="content-input-filed">
                                    <dx:ASPxTextBox ID="txtOsebaID" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                        ReadOnly="true" BackColor="LightGray">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                    </dx:ASPxTextBox>
                                </div>
                            </div>
                            <div class="col popup span_1_of_2 no-margin-left-important">
                                <div class="content-form-element-label-flex lable-width-large">
                                    <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="IME :"></dx:ASPxLabel>
                                </div>
                                <div class="content-input-filed">
                                    <dx:ASPxTextBox ID="txtIme" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                        MaxLength="60">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                        <ValidationSettings ValidationGroup="Confirm" Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true"
                                            RequiredField-ErrorText="Enter valid value">
                                            <RequiredField IsRequired="true" />
                                        </ValidationSettings>
                                        <ClientSideEvents Init="SetFocus" />
                                    </dx:ASPxTextBox>
                                </div>
                            </div>
                            <div class="col popup span_1_of_2 align_right_column_content">
                                <div class="content-form-element-label-flex lable-width-medium">
                                    <dx:ASPxLabel ID="ASPxLabel101" runat="server" Text="PRIIMEK :"></dx:ASPxLabel>
                                </div>
                                <div class="content-input-filed">
                                    <dx:ASPxTextBox ID="txtPriimek" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                        MaxLength="60">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                    </dx:ASPxTextBox>
                                </div>
                            </div>
                            <div class="col popup span_1_of_2 no-margin-left-important">
                                <div class="content-form-element-label-flex lable-width-large">
                                    <dx:ASPxLabel ID="ASPxLabel7" runat="server" Text="NASLOV :"></dx:ASPxLabel>
                                </div>
                                <div class="content-input-filed">
                                    <dx:ASPxTextBox ID="txtNaslov" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                        MaxLength="160">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                    </dx:ASPxTextBox>
                                </div>
                            </div>
                            <div class="col popup span_1_of_2 align_right_column_content">
                                <div class="content-form-element-label-flex lable-width-medium">
                                    <dx:ASPxLabel ID="ASPxLabel8" runat="server" Text="TELEFON :"></dx:ASPxLabel>
                                </div>
                                <div class="content-input-filed">
                                    <dx:ASPxTextBox ID="txtTelefon" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                        MaxLength="60">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                    </dx:ASPxTextBox>
                                </div>
                            </div>
                            <div class="col popup span_1_of_2 no-margin-left-important">
                                <div class="content-form-element-label-flex lable-width-large">
                                    <dx:ASPxLabel ID="ASPxLabel9" runat="server" Text="DATUM ROJ. :"></dx:ASPxLabel>
                                </div>
                                <div class="content-input-filed">
                                    <dx:ASPxDateEdit ID="ASPxDateEditDatumRojstva" runat="server" Width="100px" Theme="DevEx"
                                        HorizontalAlign="right" Font-Size="Small" CssClass="text-box-input" 
                                        PopupVerticalAlign="TopSides">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                        <CalendarProperties TodayButtonText="Danes" ClearButtonText="Izbriši" ></CalendarProperties>
                                        <DropDownButton Visible="true"></DropDownButton>
                                    </dx:ASPxDateEdit>
                                </div>
                            </div>
                            <div class="col popup span_1_of_2 align_right_column_content">
                                <div class="content-form-element-label-flex lable-width-xtra-large">
                                    <dx:ASPxLabel ID="ASPxLabel10" runat="server" Width="110px" Text="DATUM ZAPOSL. :"></dx:ASPxLabel>
                                </div>
                                <div class="content-input-filed">
                                    <dx:ASPxDateEdit ID="ASPxDateEditDatumZaposlitve" runat="server" Width="100px" Theme="DevEx"
                                        HorizontalAlign="right" CssClass="text-box-input" Font-Size="Small" PopupVerticalAlign="TopSides">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                        <CalendarProperties TodayButtonText="Danes" ClearButtonText="Izbriši"></CalendarProperties>
                                        <DropDownButton Visible="true"></DropDownButton>
                                    </dx:ASPxDateEdit>
                                </div>
                            </div>
                            <div class="col popup span_1_of_2 no-margin-left-important">
                                <div class="content-form-element-label-flex lable-width-large">
                                    <dx:ASPxLabel ID="ASPxLabel11" runat="server" Text="ZUNANJI :"></dx:ASPxLabel>
                                </div>
                                <div class="content-input-filed">
                                    <dx:ASPxComboBox ID="ComboBoxZunanji" runat="server" Width="80px" CssClass="text-box-input">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                        <Items>
                                            <dx:ListEditItem Text="DA" Value="1" />
                                            <dx:ListEditItem Text="NE" Value="0" Selected="true" />
                                        </Items>
                                    </dx:ASPxComboBox>
                                </div>
                            </div>
                            <div class="col popup span_1_of_2 align_right_column_content">
                                <div class="content-form-element-label-flex lable-width-medium">
                                    <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="DEl. MESTO :"></dx:ASPxLabel>
                                </div>
                                <div class="content-input-filed">
                                    <dx:ASPxTextBox ID="txtDelovnoMesto" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                        MaxLength="200">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                    </dx:ASPxTextBox>
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
                                        ValidationGroup="Confirm">
                                    </dx:ASPxButton>
                                </span>
                            </div>
                        </div>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Name="UserCredentialData" Text="UPORABNIŠKI PODATKI">
                <ContentCollection>
                    <dx:ContentControl ID="ContentControl2" runat="server">
                        <div class="section group">
                            <div class="col popup span_2_of_2 no-margin-left-important">
                                <div class="content-form-element-label-flex lable-width-medium">
                                    <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="EMAIL :"></dx:ASPxLabel>
                                </div>
                                <div class="content-input-filed">
                                    <dx:ASPxTextBox ID="txtEmail" runat="server" Width="300px" Font-Size="Small" CssClass="text-box-input"
                                        MaxLength="200">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                        <ClientSideEvents Init="SetFocus" />
                                    </dx:ASPxTextBox>
                                </div>
                            </div>
                            <div class="col popup span_2_of_2 no-margin-left-important">
                                <div class="content-form-element-label-flex lable-width-medium">
                                    <dx:ASPxLabel ID="ASPxLabel5" runat="server" Width="120px" Text="UPORABNIŠKO IME :"></dx:ASPxLabel>
                                </div>
                                <div class="content-input-filed">
                                    <dx:ASPxTextBox ID="txtUporabniskoIme" runat="server" Width="300px" Font-Size="Small" CssClass="text-box-input"
                                        MaxLength="100">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                    </dx:ASPxTextBox>
                                </div>
                            </div>
                            <div class="col popup span_2_of_2 no-margin-left-important">
                                <div class="content-form-element-label-flex lable-width-medium">
                                    <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="GESLO :"></dx:ASPxLabel>
                                </div>
                                <div class="content-input-filed">
                                    <dx:ASPxTextBox ID="txtGeslo" runat="server" Width="300px" Font-Size="Small" CssClass="text-box-input"
                                        MaxLength="100">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                    </dx:ASPxTextBox>
                                </div>
                            </div>
                            <div class="col popup span_2_of_2 no-margin-left-important">
                                <div class="content-form-element-label-flex lable-width-medium">
                                    <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="VLOGA :"></dx:ASPxLabel>
                                </div>
                                <div class="content-input-filed">
                                    <dx:ASPxComboBox ID="ComboBoxVloge" runat="server" ValueType="System.String" DropDownStyle="DropDownList"
                                        IncrementalFilteringMode="StartsWith" TextField="Koda" ValueField="idVloga"
                                        EnableSynchronization="False" OnDataBinding="ComboBoxVloge_DataBinding"
                                        Font-Size="Small" CssClass="text-box-input">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                    </dx:ASPxComboBox>
                                </div>
                            </div>
                            <div class="col popup span_2_of_2 no-margin-left-important">
                                <div class="content-form-element-label-flex lable-width-medium">
                                    <dx:ASPxLabel ID="ASPxLabel12" runat="server" Text="NADREJENI :"></dx:ASPxLabel>
                                </div>
                                <div class="content-input-filed">
                                    <dx:ASPxComboBox ID="ComboBoxNadrejeni" runat="server" ValueType="System.String" DropDownStyle="DropDownList"
                                        IncrementalFilteringMode="StartsWith" TextField="CelotnoIme" ValueField="idOsebe"
                                        EnableSynchronization="False" OnDataBinding="ComboBoxNadrejeni_DataBinding"
                                        Font-Size="Small" CssClass="text-box-input">
                                        <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                    </dx:ASPxComboBox>
                                </div>
                            </div>
                        </div>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
        </TabPages>
    </dx:ASPxPageControl>
    <%--<script type="text/javascript" src="../../../Scripts/ChromeFix_14.js"></script>--%>
</asp:Content>
