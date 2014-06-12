function Item_Charge_Actions takes nothing returns nothing
    local item itmPrev
    if(GetItemType(GetManipulatedItem()) == ITEM_TYPE_PURCHASABLE)then
        call DisableTrigger( GetTriggeringTrigger() )
        call UnitRemoveItemSwapped(GetManipulatedItem(),GetManipulatingUnit())
        set itmPrev = bj_lastRemovedItem
        call UnitRemoveItemSwapped(GetItemOfTypeFromUnitBJ(GetManipulatingUnit(),GetItemTypeId(GetManipulatedItem())),GetManipulatingUnit())
        call SetItemCharges(itmPrev,(GetItemCharges(bj_lastRemovedItem)+GetItemCharges(itmPrev)))
        call UnitAddItem(GetTriggerUnit(),itmPrev)
        call RemoveItem(bj_lastRemovedItem)
        call EnableTrigger(GetTriggeringTrigger())
    endif
endfunction

//===========================================================================
function InitTrig_Item_Charge takes nothing returns nothing
    local trigger t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ( t, EVENT_PLAYER_UNIT_PICKUP_ITEM )
    call TriggerAddAction( t, function Item_Charge_Actions)
endfunction
