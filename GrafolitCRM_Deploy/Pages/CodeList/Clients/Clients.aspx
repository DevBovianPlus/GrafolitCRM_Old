<%@ Page Language="C#" MasterPageFile="~/MasterPage.Master" Title="Stranke" AutoEventWireup="true" CodeBehind="Clients.aspx.cs" Inherits="AnalizaProdaje.Pages.CodeList.Clients.Clients" %>

<%@ MasterType VirtualPath="~/MasterPage.Master" %>

<asp:Content ID="HeadForJavaScript" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function RowDoubleClick(s, e) {
            gridClients.GetRowValues(gridClients.GetFocusedRowIndex(), 'idStranka', OnGetRowValues);
        }
        function OnGetRowValues(value) {
            callback.PerformCallback('DblClick;' + value);
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

    <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" ShowCollapseButton="false" Theme="MetropolisBlue"
        HeaderStyle-HorizontalAlign="Center" Font-Bold="true" Width="100%" HeaderText="Stranke">
        <ContentPaddings PaddingBottom="7px" PaddingLeft="3px" PaddingRight="3px" PaddingTop="7px" />
        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
        <PanelCollection>
            <dx:PanelContent>
                <dx:ASPxCallback ID="ASPxCallback1" runat="server" ClientInstanceName="callback" OnCallback="ASPxCallback1_Callback"></dx:ASPxCallback>

                <dx:ASPxButton ID="btnExportStranke" runat="server" RenderMode="Link" ClientEnabled="true" OnClick="btnExportStranke_Click"
                    AutoPostBack="false" UseSubmitBehavior="false" ClientInstanceName="clientbtnExportStranke" ToolTip="Izvozi v excel">
                    <DisabledStyle CssClass="icon-disabled" />
                    <HoverStyle CssClass="icon-hover" />
                    <Image Url="../../../Images/pdf-export.png" Width="30px" />
                </dx:ASPxButton>
                <dx:ASPxGridViewExporter ID="ASPxGridViewExporterStranke" GridViewID="ASPxGridViewStranke" runat="server"></dx:ASPxGridViewExporter>
                <dx:ASPxGridView ID="ASPxGridViewStranke" runat="server" AutoGenerateColumns="False"
                    EnableTheming="True" EnableCallbackCompression="true" ClientInstanceName="gridClients"
                    Theme="Moderno" Width="100%" KeyboardSupport="true" AccessKey="G"
                    KeyFieldName="idStranka" OnDataBinding="ASPxGridViewStranke_DataBinding"
                    Paddings-PaddingTop="0" Paddings-PaddingBottom="0"
                    CssClass="gridview-no-header-padding">
                    <%--ColumnResizeMode="Disabled" for setting column width with css--%>
                    <ClientSideEvents RowDblClick="RowDoubleClick" />
                    <SettingsPager PageSize="10" ShowNumericButtons="true">

                        <PageSizeItemSettings Visible="true" Items="10,20,30" Caption="Zapisi na stran : " AllItemText="Vsi">
                        </PageSizeItemSettings>
                        <Summary Visible="true" Text="Vseh zapisov : {2}" EmptyText="Ni zapisov" />
                    </SettingsPager>
                    <Settings ShowVerticalScrollBar="True" VerticalScrollableHeight="400"
                        ShowHorizontalScrollBar="True" ShowFilterBar="Auto" ShowFilterRow="True"
                        ShowFilterRowMenu="True" VerticalScrollBarStyle="Standard" />
                    <SettingsBehavior AllowFocusedRow="true" />

                    <SettingsPopup>
                        <HeaderFilter MinHeight="140px"></HeaderFilter>
                    </SettingsPopup>
                    <Columns>
                        <%-- <dx:GridViewDataTextColumn Caption="FAX" FieldName="FAX" Width="120px"
                            Visible="true" ReadOnly="true" ShowInCustomizationForm="True" VisibleIndex="11" Visible="false">
                            <PropertiesTextEdit DisplayFormatString="###/###-###"></PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Internetni Nalov" FieldName="InternetniNalov" Width="185px"
                            Visible="true" ReadOnly="true" ShowInCustomizationForm="True" VisibleIndex="12" Visible="false">
                        </dx:GridViewDataTextColumn>--%>
                        <dx:GridViewCommandColumn ShowInCustomizationForm="True" VisibleIndex="0" Visible="false">
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn Caption="ID" FieldName="idStranka" Width="80px"
                            ReadOnly="true" Visible="false" ShowInCustomizationForm="True" VisibleIndex="1">
                        </dx:GridViewDataTextColumn>

                        <dx:GridViewDataTextColumn Caption="Koda" FieldName="KodaStranke" Width="250px"
                            ReadOnly="true" ShowInCustomizationForm="True" VisibleIndex="2" Visible="false">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Rang" FieldName="RangStranke" Width="7%"
                            ReadOnly="true" ShowInCustomizationForm="True" VisibleIndex="3">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Naziv Prvi"
                            FieldName="NazivPrvi" ShowInCustomizationForm="True"
                            VisibleIndex="4" Width="22%">
                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>

                        <dx:GridViewDataTextColumn Caption="Naziv drugi"
                            FieldName="NazivDrugi" ShowInCustomizationForm="True"
                            VisibleIndex="5" Width="34%">
                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>

                        <dx:GridViewDataTextColumn Caption="Naslov"
                            FieldName="Naslov" ShowInCustomizationForm="True"
                            VisibleIndex="6" Width="27%">
                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>

                        <dx:GridViewDataTextColumn Caption="Telefon"
                            FieldName="Telefon" ShowInCustomizationForm="True"
                            VisibleIndex="7" Width="12%">
                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Skrbnik"
                            FieldName="ImeInPriimekZaposlen" ShowInCustomizationForm="True"
                            VisibleIndex="8" Width="15%">
                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>

                        <dx:GridViewDataTextColumn Caption="Zadnji status dog."
                            FieldName="LastDogodekNaziv" ShowInCustomizationForm="True"
                            VisibleIndex="8" Width="15%">
                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>

                        <%--<dx:GridViewDataCheckColumn Caption="Aktivnost" FieldName="Aktivnost" ShowInCustomizationForm="True" VisibleIndex="9">

                            <CellStyle Paddings-Padding="0"></CellStyle>
                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                        </dx:GridViewDataCheckColumn>--%>
                    </Columns>
                    <Styles Header-Wrap="True">
                        <Header Paddings-PaddingTop="5" HorizontalAlign="Center" VerticalAlign="Middle" Font-Bold="true">
                            <Paddings PaddingTop="5px"></Paddings>
                        </Header>
                        <FocusedRow BackColor="#d1e6fe" Font-Bold="true" ForeColor="#606060"></FocusedRow>
                    </Styles>

                    <Paddings PaddingTop="0px" PaddingBottom="0px"></Paddings>
                </dx:ASPxGridView>
                <div class="AddEditButtonsWrap">
                    <div class="DeleteButtonElements">
                        <span class="AddEditButtons">
                            <dx:ASPxButton ID="btnDelete" runat="server" Text="Izbriši" AutoPostBack="false" OnClick="btnDelete_Click"
                                Height="25" Width="90">
                                <Image Url="../../../Images/trash2.png"></Image>
                            </dx:ASPxButton>
                        </span>
                    </div>
                    <div class="AddEditButtonsElements">
                        <span class="AddEditButtons">
                            <dx:ASPxButton ID="btnAdd" runat="server" Text="Dodaj" AutoPostBack="false" OnClick="btnAdd_Click"
                                Height="25" Width="90">
                                <Image Url="../../../Images/add2.png"></Image>
                            </dx:ASPxButton>
                        </span>
                        <span class="AddEditButtons">
                            <dx:ASPxButton ID="btnEdit" runat="server" Text="Spremeni" AutoPostBack="false" OnClick="btnEdit_Click"
                                Height="25" Width="90">
                                <Image Url="../../../Images/edit2.png"></Image>
                            </dx:ASPxButton>
                        </span>
                    </div>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxRoundPanel>

</asp:Content>
