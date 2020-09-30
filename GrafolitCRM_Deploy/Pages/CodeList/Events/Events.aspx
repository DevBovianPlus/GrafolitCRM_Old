<%@ Page Language="C#" MasterPageFile="~/MasterPage.Master" Title="Dogodki" AutoEventWireup="true" CodeBehind="Events.aspx.cs" Inherits="AnalizaProdaje.Pages.CodeList.Events.Events" %>

<%@ MasterType VirtualPath="~/MasterPage.Master" %>

<asp:Content ID="HeadForJavaScript" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function RowDoubleClick(s, e) {
            gridEvents.GetRowValues(gridEvents.GetFocusedRowIndex(), 'idDogodek', OnGetRowValues);
        }
        function OnGetRowValues(value) {
            callback.PerformCallback('DblClick;' + value);
        }

    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

    <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" ShowCollapseButton="false" Theme="MetropolisBlue"
        HeaderStyle-HorizontalAlign="Center" Font-Bold="true" Width="100%" HeaderText="Dogodki">
        <ContentPaddings PaddingBottom="7px" PaddingLeft="3px" PaddingRight="3px" PaddingTop="7px" />
        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
        <PanelCollection>
            <dx:PanelContent>
                <dx:ASPxCallback ID="ASPxCallback1" runat="server" ClientInstanceName="callback" OnCallback="ASPxCallback1_Callback"></dx:ASPxCallback>
                <dx:ASPxButton ID="btnExportEvents" runat="server" RenderMode="Link" ClientEnabled="true" OnClick="btnExportEvents_Click"
                    AutoPostBack="false" UseSubmitBehavior="false" ClientInstanceName="clientbtnExportStranke" ToolTip="Izvozi v excel">
                    <DisabledStyle CssClass="icon-disabled" />
                    <HoverStyle CssClass="icon-hover" />
                    <Image Url="../../../Images/pdf-export.png" Width="30px" />
                </dx:ASPxButton>
                <dx:ASPxGridViewExporter ID="ASPxGridViewExporterEvents" GridViewID="ASPxGridViewEvents" runat="server"></dx:ASPxGridViewExporter>
                <dx:ASPxGridView ID="ASPxGridViewEvents" runat="server" AutoGenerateColumns="False"
                    EnableTheming="True" EnableCallbackCompression="true" ClientInstanceName="gridEvents"
                    Theme="Moderno" Width="100%" KeyboardSupport="true" AccessKey="G"
                    KeyFieldName="idDogodek" OnDataBinding="ASPxGridViewEvents_DataBinding"
                    Paddings-PaddingTop="0" Paddings-PaddingBottom="0"
                    CssClass="gridview-no-header-padding">
                    <ClientSideEvents RowDblClick="RowDoubleClick" />
                    <Settings ShowVerticalScrollBar="True" VerticalScrollableHeight="400"
                        ShowHorizontalScrollBar="True" ShowFilterBar="Auto" ShowFilterRow="True"
                        ShowFilterRowMenu="True" VerticalScrollBarStyle="Standard" />
                    <SettingsPager PageSize="10" ShowNumericButtons="true">
                        <PageSizeItemSettings Visible="true" Items="10,20,30" Caption="Zapisi na stran : " AllItemText="Vsi">
                        </PageSizeItemSettings>
                        <Summary Visible="true" Text="Vseh zapisov : {2}" />
                    </SettingsPager>
                    <SettingsBehavior AllowFocusedRow="true" />
                    <Styles Header-Wrap="True">
                        <Header Paddings-PaddingTop="5" HorizontalAlign="Center" VerticalAlign="Middle" Font-Bold="true"></Header>
                        <FocusedRow BackColor="#d1e6fe" Font-Bold="true" ForeColor="#606060"></FocusedRow>
                    </Styles>
                    <Columns>
                        <dx:GridViewDataTextColumn Caption="ID" FieldName="idDogodek" Width="80px"
                            ReadOnly="true" ShowInCustomizationForm="True" VisibleIndex="1" Visible="false">
                        </dx:GridViewDataTextColumn>                       
                        <dx:GridViewDataTextColumn Caption="Kategorija"
                            FieldName="Kategorija" ShowInCustomizationForm="True"
                            VisibleIndex="3" Width="10%">
                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Nadrejeni"
                            FieldName="OsebeSkrbnik" ShowInCustomizationForm="True"
                            VisibleIndex="4" Width="170px" Visible="false">
                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Skrbnik"
                            FieldName="OsebeIzvajalec" ShowInCustomizationForm="True"
                            VisibleIndex="5" Width="13%">
                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Status"
                            FieldName="StatusDogodek" ShowInCustomizationForm="True"
                            VisibleIndex="6" Width="10%">
                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Opis"
                            FieldName="Opis" ShowInCustomizationForm="True"
                            VisibleIndex="7" Width="27%">
                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn Caption="Datum otvoritve"
                            FieldName="DatumOtvoritve" ShowInCustomizationForm="True"
                            VisibleIndex="8" Width="10%">
                            <PropertiesDateEdit DisplayFormatString="dd.MM.yyyy"></PropertiesDateEdit>
                            <CellStyle HorizontalAlign="Right"></CellStyle>
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataDateColumn Caption="Rok"
                            FieldName="Rok" ShowInCustomizationForm="True"
                            VisibleIndex="9" Width="10%">
                            <PropertiesDateEdit DisplayFormatString="dd.MM.yyyy"></PropertiesDateEdit>
                            <CellStyle HorizontalAlign="Right"></CellStyle>
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataDateColumn Caption="Datum vpisa"
                            FieldName="ts" ShowInCustomizationForm="True"
                            VisibleIndex="9" Width="10%" Visible="true">
                            <PropertiesDateEdit DisplayFormatString="dd.MM.yyyy - HH:mm"></PropertiesDateEdit>
                            <CellStyle HorizontalAlign="Right"></CellStyle>
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn Caption="Vnesel"
                            FieldName="VneselOseba" ShowInCustomizationForm="True"
                            VisibleIndex="10" Width="10%" Visible="true">
                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                    </Columns>
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
                    <div style="display: inline-block; position: relative; left: 30%">
                        <dx:ASPxLabel ID="ErrorLabel" runat="server" ForeColor="Red" Font-Size="Medium" ClientVisible="false" Text="Zaključen ali V Teku dogodek ni dovoljeno brisati"></dx:ASPxLabel>
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
