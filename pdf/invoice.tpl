{*
* 2007-2015 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2015 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}
<div style="font-size: 8pt; color: #444">

<table>
	<tr><td>&nbsp;</td></tr>
</table>

<!-- ADDRESSES -->
<table style="width: 100%">
	<tr>
		<td style="width: 17%"></td>
		<td style="width: 83%">
			{if !empty($delivery_address)}
				<table style="width: 100%">
					<tr>
						<td style="width: 50%">
							<span style="font-weight: bold; font-size: 10pt; color: #9E9F9E">{l s='Delivery Address' pdf='true'}</span><br />
							 {$delivery_address}
						</td>
						<td style="width: 50%">
							<span style="font-weight: bold; font-size: 10pt; color: #9E9F9E">{l s='Billing Address' pdf='true'}</span><br />
							 {$invoice_address}
						</td>
					</tr>
				</table>
			{else}
				<table style="width: 100%">
					<tr>

						<td style="width: 50%">
							<span style="font-weight: bold; font-size: 10pt; color: #9E9F9E">{l s='Billing & Delivery Address.' pdf='true'}</span><br />
							 {$invoice_address}
						</td>
						<td style="width: 50%">

						</td>
					</tr>
				</table>
			{/if}
		</td>
	</tr>
</table>
<!-- / ADDRESSES -->

<div style="line-height: 1pt">&nbsp;</div>

<!-- PRODUCTS TAB -->
<table style="width: 100%">
	<tr>
		<td style="width: 17%; padding-right: 7px; text-align: right; vertical-align: top; font-size: 7pt;">
			<!-- CUSTOMER INFORMATION -->
			<b>{l s='Order Number:' pdf='true'}</b><br />
			{$order->getUniqReference()}<br />
			<br />
			<b>{l s='Order Date:' pdf='true'}</b><br />
			{dateFormat date=$order->date_add full=0}<br />
			<br />
			<b>{l s='Payment Method:' pdf='true'}</b><br />
			<table style="width: 100%;">
			{foreach from=$order_invoice->getOrderPaymentCollection() item=payment}
				<tr>
					<td>
						<strong style="font-style: italic">{$payment->payment_method}</strong><br>
						{displayPrice price=$payment->amount currency=$order->id_currency}
					</td>
				</tr>
			{foreachelse}
				<tr>
					<td>{l s='No payment' pdf='true'}</td>
				</tr>
			{/foreach}
			</table>
			<br />
			{if isset($carrier)}
			<b>{l s='Carrier:' pdf='true'}</b><br />
			{$carrier->name}<br />
			<br />
			{/if}
			<!-- / CUSTOMER INFORMATION -->
		</td>
		<td style="width: 83%; text-align: right">
			<table style="width: 100%; font-size: 8pt;">
				<tr style="line-height:4px;">
					{$product_reference_width = 45}
					{if Configuration::get('PS_PDF_IMG_INVOICE')}
						{$product_reference_width = $product_reference_width - 10}
						<td style="text-align: left; background-color: #4D4D4D; color: #FFF; padding-left: 10px; font-weight: bold; width: 10%">{l s='Image' pdf='true'}</td>
					{/if}
					{if !$tax_excluded_display}
						{$product_reference_width = $product_reference_width - 10}
					{/if}
					<td style="text-align: left; background-color: #4D4D4D; color: #FFF; padding-left: 10px; font-weight: bold; width: {$product_reference_width}%">{l s='Product / Reference' pdf='true'}</td>
					<!-- unit price tax excluded is mandatory -->
					{if !$tax_excluded_display}
						<td style="background-color: #4D4D4D; color: #FFF; text-align: right; font-weight: bold; width: 20%">{l s='Unit Price' pdf='true'} <br />{l s='(Tax Excl.)' pdf='true'}</td>
					{/if}
					<td style="background-color: #4D4D4D; color: #FFF; text-align: right; font-weight: bold; width: 10%">
						{l s='Unit Price' pdf='true'}
						{if $tax_excluded_display}
							 {l s='(Tax Excl.)' pdf='true'}
						{else}
							 {l s='(Tax Incl.)' pdf='true'}
						{/if}
					</td>
					<td style="background-color: #4D4D4D; color: #FFF; text-align: right; font-weight: bold; width: 10%; white-space: nowrap;">{l s='Discount' pdf='true'}</td>
					<td style="background-color: #4D4D4D; color: #FFF; text-align: center; font-weight: bold; width: 10%">{l s='Qty' pdf='true'}</td>
					<td style="background-color: #4D4D4D; color: #FFF; text-align: right; font-weight: bold; width: {if !$tax_excluded_display}15%{else}25%{/if}">
						{l s='Total' pdf='true'}
						{if $tax_excluded_display}
							{l s='(Tax Excl.)' pdf='true'}
						{else}
							{l s='(Tax Incl.)' pdf='true'}
						{/if}
					</td>
				</tr>
				<!-- PRODUCTS -->
				{foreach $order_details as $order_detail}
				{cycle values='#FFF,#DDD' assign=bgcolor}
				<tr style="line-height:6px;background-color:{$bgcolor};" {if Configuration::get('PS_PDF_IMG_INVOICE') && isset($order_detail.image) && $order_detail.image->id && isset($order_detail.image_size)}height="{$order_detail['image_size'][1]}"{/if}>
					{if Configuration::get('PS_PDF_IMG_INVOICE')}
						<td style="text-align: left;">{if isset($order_detail.image) && $order_detail.image->id}{$order_detail.image_tag}{/if}</td>
					{/if}
					<td style="text-align: left; width: {$product_reference_width}%">{$order_detail.product_name}{if isset($order_detail.product_reference) && !empty($order_detail.product_reference)} ({l s='Reference:' pdf='true'} {$order_detail.product_reference}){/if}</td>
					<!-- unit price tax excluded is mandatory -->
					{if !$tax_excluded_display}
						<td style="text-align: right; width: 20%; white-space: nowrap;">
							{displayPrice currency=$order->id_currency price=$order_detail.unit_price_tax_excl_including_ecotax}
							{if $order_detail.ecotax_tax_excl > 0}
								<br>
								<small>{{displayPrice currency=$order->id_currency price=$order_detail.ecotax_tax_excl}|string_format:{l s='ecotax: %s' pdf='true'}}</small>
							{/if}
						</td>
					{/if}
					<td style="text-align: right; width: 10%; white-space: nowrap;">
					{if $tax_excluded_display}
						{displayPrice currency=$order->id_currency price=$order_detail.unit_price_tax_excl_including_ecotax}
						{if $order_detail.ecotax_tax_excl > 0}
							<br>
							<small>{{displayPrice currency=$order->id_currency price=$order_detail.ecotax_tax_excl}|string_format:{l s='ecotax: %s' pdf='true'}}</small>
						{/if}
					{else}
						{displayPrice currency=$order->id_currency price=$order_detail.unit_price_tax_incl_including_ecotax}
						{if $order_detail.ecotax_tax_incl > 0}
							<br>
							<small>{{displayPrice currency=$order->id_currency price=$order_detail.ecotax_tax_incl}|string_format:{l s='ecotax: %s' pdf='true'}}</small>
						{/if}
					{/if}
					</td>
					<td style="text-align: right; width: 10%">
					{if (isset($order_detail.reduction_amount) && $order_detail.reduction_amount > 0)}
						-{displayPrice currency=$order->id_currency price=$order_detail.reduction_amount}
					{elseif (isset($order_detail.reduction_percent) && $order_detail.reduction_percent > 0)}
						-{$order_detail.reduction_percent}%
					{else}
					--
					{/if}
					</td>
					<td style="text-align: center; width: 10%">{$order_detail.product_quantity}</td>
					<td style="text-align: right;  width: {if !$tax_excluded_display}15%{else}25%{/if}; white-space: nowrap;">
					{if $tax_excluded_display}
						{displayPrice currency=$order->id_currency price=$order_detail.total_price_tax_excl_including_ecotax}
					{else}
						{displayPrice currency=$order->id_currency price=$order_detail.total_price_tax_incl_including_ecotax}
					{/if}
					</td>
				</tr>
					{foreach $order_detail.customizedDatas as $customizationPerAddress}
						{foreach $customizationPerAddress as $customizationId => $customization}
							<tr style="line-height:6px;background-color:{$bgcolor};">
								<td style="line-height:3px; text-align: left; width: 45%; vertical-align: top">
										<blockquote>
											{if isset($customization.datas[Product::CUSTOMIZE_TEXTFIELD]) && count($customization.datas[Product::CUSTOMIZE_FILE]) > 0}
												{foreach $customization.datas[Product::CUSTOMIZE_TEXTFIELD] as $customization_infos}
													{$customization_infos.name}: {$customization_infos.value}
													{if !$smarty.foreach.custo_foreach.last}<br />
													{else}
													<div style="line-height:0.4pt">&nbsp;</div>
													{/if}
												{/foreach}
											{/if}

											{if isset($customization.datas[Product::CUSTOMIZE_FILE]) && count($customization.datas[Product::CUSTOMIZE_FILE]) > 0}
												{count($customization.datas[Product::CUSTOMIZE_FILE])} {l s='image(s)' pdf='true'}
											{/if}
										</blockquote>
								</td>
								{if !$tax_excluded_display}
									<td style="text-align: right;"></td>
								{/if}
								<td style="text-align: right; width: 10%"></td>
								<td style="text-align: center; width: 10%; vertical-align: top">({$customization.quantity})</td>
								<td style="width: 15%; text-align: right;"></td>
							</tr>
						{/foreach}
					{/foreach}
				{/foreach}
				<!-- END PRODUCTS -->

				<!-- CART RULES -->
				{assign var="shipping_discount_tax_incl" value="0"}
				{foreach from=$cart_rules item=cart_rule name="cart_rules_loop"}
					{cycle values='#FFF,#DDD' assign=bgcolor}
					{if $smarty.foreach.cart_rules_loop.first}
						<tr>
							<td style="text-align:left" colspan="{if $tax_excluded_display}5{else}6{/if}">
								<br><br>
								<span style="font-style: italic">{l s='Discounts' pdf='true'}</span>
							</td>
						</tr>
					{/if}
					<tr style="line-height:6px;background-color:{$bgcolor};text-align:left;">
						<td style="text-align:left;width:60%;vertical-align:top" colspan="{if $tax_excluded_display}4{else}5{/if}">
							{$cart_rule.name}
						</td>
						<td style="text-align:right;width:40%;vertical-align:top">
							{if $tax_excluded_display}
								- {displayPrice currency=$order->id_currency price=$cart_rule.value_tax_excl}
							{else}
								- {displayPrice currency=$order->id_currency price=$cart_rule.value}
							{/if}
						</td>
					</tr>
				{/foreach}
				<!-- END CART RULES -->
			</table>

			<br>

			{if $tax_excluded_display}
				<table style="width: 100%">

					<tr style="line-height:5px;">
						<td style="width: 83%; text-align: right; font-weight: bold">{l s='Product Total (Tax Excl.)' pdf='true'}</td>
						<td style="width: 17%; text-align: right;">{displayPrice currency=$order->id_currency price=$footer.products_before_discounts_tax_excl}</td>
					</tr>

					{if $footer.product_discounts_tax_excl > 0}
						<tr style="line-height:5px;">
							<td style="text-align: right; font-weight: bold">{l s='Total Discounts (Tax Excl.)' pdf='true'}</td>
							<td style="width: 17%; text-align: right;">-{displayPrice currency=$order->id_currency price=$footer.product_discounts_tax_excl}</td>
						</tr>
						<tr style="line-height:5px; font-style: italic;">
							<td style="text-align: right; font-weight: bold">{l s='Product Total After Discounts (Tax Excl.)' pdf='true'}</td>
							<td style="width: 17%; text-align: right;">{displayPrice currency=$order->id_currency price=$footer.products_after_discounts_tax_excl}</td>
						</tr>
					{/if}

					{if $footer.shipping_tax_excl > 0}
						<tr style="line-height:5px;">
							<td style="text-align: right; font-weight: bold">{l s='Shipping Cost (Tax Excl.)' pdf='true'}</td>
							<td style="width: 17%; text-align: right;">{displayPrice currency=$order->id_currency price=$footer.shipping_tax_excl}</td>
						</tr>
					{/if}

					{if $footer.wrapping_tax_excl > 0}
						<tr style="line-height:5px;">
							<td style="text-align: right; font-weight: bold">{l s='Wrapping Cost (Tax Excl.)' pdf='true'}</td>
							<td style="width: 17%; text-align: right;">{displayPrice currency=$order->id_currency price=$footer.wrapping_tax_excl}</td>
						</tr>
					{/if}

					{if $footer.product_taxes > 0}
						<tr style="line-height:5px;">
							<td style="text-align: right; font-weight: bold">{l s='Product Taxes' pdf='true'}</td>
							<td style="width: 17%; text-align: right;">{displayPrice currency=$order->id_currency price=$footer.product_taxes}</td>
						</tr>
					{/if}

					{if $footer.ecotax_taxes > 0}
						<tr style="line-height:5px;">
							<td style="text-align: right; font-weight: bold">{l s='Ecotax Tax' pdf='true'}</td>
							<td style="width: 17%; text-align: right;">{displayPrice currency=$order->id_currency price=$footer.ecotax_taxes}</td>
						</tr>
					{/if}

					{if $footer.shipping_taxes > 0}
						<tr style="line-height:5px;">
							<td style="text-align: right; font-weight: bold">{l s='Shipping Taxes' pdf='true'}</td>
							<td style="width: 17%; text-align: right;">{displayPrice currency=$order->id_currency price=$footer.shipping_taxes}</td>
						</tr>
					{/if}

					{if $footer.wrapping_taxes > 0}
						<tr style="line-height:5px;">
							<td style="text-align: right; font-weight: bold">{l s='Wrapping Taxes' pdf='true'}</td>
							<td style="width: 17%; text-align: right;">{displayPrice currency=$order->id_currency price=$footer.wrapping_taxes}</td>
						</tr>
					{/if}

					{if $footer.total_taxes > 0}
						<tr style="line-height:5px; font-style: italic">
							<td style="text-align: right; font-weight: bold">{l s='Total Taxes' pdf='true'}</td>
							<td style="width: 17%; text-align: right;">{displayPrice currency=$order->id_currency price=$footer.total_taxes}</td>
						</tr>
					{/if}

					<tr style="line-height:5px;">
						<td style="text-align: right; font-weight: bold">{l s='Total' pdf='true'}</td>
						<td style="width: 17%; text-align: right;">{displayPrice currency=$order->id_currency price=$footer.total_paid_tax_incl}</td>
					</tr>

				</table>
			{else}
				<table style="width: 100%">

					<tr style="line-height:5px;">
						<td style="width: 83%; text-align: right; font-weight: bold">{l s='Product Total (Tax Incl.)' pdf='true'}</td>
						<td style="width: 17%; text-align: right;">{displayPrice currency=$order->id_currency price=$footer.products_before_discounts_tax_incl}</td>
					</tr>

					{if $footer.product_discounts_tax_incl > 0}
						<tr style="line-height:5px;">
							<td style="text-align: right; font-weight: bold">{l s='Total Discounts (Tax Incl.)' pdf='true'}</td>
							<td style="width: 17%; text-align: right;">-{displayPrice currency=$order->id_currency price=$footer.product_discounts_tax_incl}</td>
						</tr>
					{/if}

					{if $footer.shipping_tax_incl > 0}
						<tr style="line-height:5px;">
							<td style="text-align: right; font-weight: bold">{l s='Shipping Cost (Tax Incl.)' pdf='true'}</td>
							<td style="width: 17%; text-align: right;">{displayPrice currency=$order->id_currency price=$footer.shipping_tax_incl}</td>
						</tr>
					{/if}

					{if $footer.wrapping_tax_incl > 0}
						<tr style="line-height:5px;">
							<td style="text-align: right; font-weight: bold">{l s='Wrapping Cost (Tax Incl.)' pdf='true'}</td>
							<td style="width: 17%; text-align: right;">{displayPrice currency=$order->id_currency price=$footer.wrapping_tax_incl}</td>
						</tr>
					{/if}

					<tr style="line-height:5px;">
						<td style="text-align: right; font-weight: bold">{l s='Total' pdf='true'}</td>
						<td style="width: 17%; text-align: right;">{displayPrice currency=$order->id_currency price=$footer.total_paid_tax_incl}</td>
					</tr>

				</table>
			{/if}

		</td>
	</tr>
</table>
<!-- / PRODUCTS TAB -->

<div style="line-height: 1pt">&nbsp;</div>

{$tax_tab}

{if isset($order_invoice->note) && $order_invoice->note}
<div style="line-height: 1pt">&nbsp;</div>
<table style="width: 100%">
	<tr>
		<td style="width: 17%"></td>
		<td style="width: 83%">{$order_invoice->note|nl2br}</td>
	</tr>
</table>
{/if}

{if isset($HOOK_DISPLAY_PDF)}
<div style="line-height: 1pt">&nbsp;</div>
<table style="width: 100%">
	<tr>
		<td style="width: 17%"></td>
		<td style="width: 83%">{$HOOK_DISPLAY_PDF}</td>
	</tr>
</table>
{/if}

</div>
