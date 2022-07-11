defmodule Kb.ConverterTest do
  use ExUnit.Case

  @test_body """
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <table cellpadding='0' cellspacing='0' border='0' width='610'>
    <tr valign='top'>
      <td width='605'>
        <table><tr></tr></table>
        <br>
        <table width='605' border='1' cellspacing='1' cellpadding='4'>
          <tr>
            <td class='td' align='center' bgcolor='#C8DFF9'>Transaction Date</td>
            <td class='td' align='center' bgcolor='#C8DFF9'>Transaction time</td>
            <td class='td' align='center' bgcolor='#C8DFF9'>Description</td>
            <td class='td' align='center' bgcolor='#C8DFF9'>Sender/ Receiver</td>
            <td class='td' align='center' bgcolor='#C8DFF9'>Memo</td>
            <td class='td' align='center' bgcolor='#C8DFF9'>Withdrawn Amount</td>
            <td class='td' align='center' bgcolor='#C8DFF9'>Deposited Amount</td>
            <td class='td' align='center' bgcolor='#C8DFF9'>Balance</td>
            <td class='td' align='center' bgcolor='#C8DFF9'>Type</td>
          </tr>
          <tr align='center'>
            <td class='td' align='center'>2016.12.24</td>
            <td class='td' align='center'>12:17:22</td>
            <td class='td' align='left'>&nbsp;Checkcard Withdraw</td>
            <td class='td' align='left'>&nbsp;레오니다스</td>
            <td class='td' align='left'>&nbsp;</td>
            <td class='td' align='right'>10,200</td>
            <td class='td' align='right'>0</td>
            <td class='td' align='right'>16,685,336</td>
            <td class='td' align='left'>&nbsp;　</td>
          </tr>
          <tr align='center'>
            <td class='td' align='center'>2016.12.25</td>
            <td class='td' align='center'>12:17:22</td>
            <td class='td' align='left'>&nbsp;Checkcard Withdraw</td>
            <td class='td' align='left'>&nbsp;레오니다스</td>
            <td class='td' align='left'>&nbsp;</td>
            <td class='td' align='right'>0</td>
            <td class='td' align='right'>10,500</td>
            <td class='td' align='right'>0</td>
            <td class='td' align='left'>&nbsp;　</td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  """

  describe "run" do
    test "parses the body" do
      assert {:ok, rows} = Kb.Converter.run(@test_body)

      assert rows == [
        ["Date", "Payee", "Category", "Memo", "Outflow", "Inflow"],
        ["24/12/2016", "레오니다스", "", "", "10.20", "0.00"],
        ["25/12/2016", "레오니다스", "", "", "0.00", "10.50"]
      ]
    end
  end
end
