<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EventsWidget.ascx.cs" Inherits="AnalizaProdaje.UserControls.Widgets.EventsWidget" %>

<div class="alignCenter">
    <asp:Repeater runat="server" ID="Repeater" OnDataBinding="Repeater_DataBinding">
        <HeaderTemplate> 
            <table style="width: 100%;">
                <thead>
                    <tr style="border-bottom: 1px solid #e9e9e9">
                        <th>Povezava</th>
                        <th>Stranka</th>
                        <th>Rok</th>
                        <th>Oseba</th>
                    </tr>
                </thead>
                <tbody>
        </HeaderTemplate>
        <ItemTemplate>
            <tr style="text-align: center; border-bottom: 1px solid #e1e1e1">
                <td>
                    <a style="text-decoration: none;" href="<%# String.Format("/Pages/CodeList/Events/EventsForm.aspx?action=2&recordId={0}", Eval("idDogodek")) %>">Info</a>
                </td>
                <td>
                    <dx:ASPxLabel ID="lblName" runat="server" Text='<%# Eval("Stranka") %>' />
                </td>
                <td>
                    <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text='<%# Eval("Rok", "{0:d}") %>' />
                </td>
                <td>
                    <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text='<%# 
                    !AnalizaProdaje.Domain.Helpers.PrincipalHelper.IsUserSalesman() ? Eval("OsebeIzvajalec") : Eval("Opis") %>' />
                </td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
            </tbody>
            </table>
        </FooterTemplate>
    </asp:Repeater>
    <dx:ASPxLabel ID="lblNoData" runat="server" Visible="false" Text="Trenutno ni prihajajočih dogodkov"></dx:ASPxLabel>
</div>
