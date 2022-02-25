/* Powers down the USB controller which is needed for proper shutdown.
 * When done incorrectly, macOS will not power down USB as it needs an
 * explicit call for S5 for proper shotdown procedure.
 * Do note this SSDT requires an ACPI hot patch for _PTS to ZPTS as 
 * we're rerouting the old calls.
 * Source for SSDT: Rehabman
 * Modify: Spectrelai
 */

DefinitionBlock ("", "SSDT", 2, "Slav", "ZPTS", 0x00000000)
{
    External (_SB_.PCI0.XHC_.PMEE, FieldUnitObj)
    External (ZPTS, MethodObj)    // 1 Arguments

    Method (_PTS, 1, NotSerialized)  // _PTS: Prepare To Sleep
    {
        ZPTS (Arg0)
        If (_OSI ("Darwin"))    // macOS
        {
            If (CondRefOf (\_SB.PCI0.XHC.PMEE))
            {
                If ((0x05 == Arg0))     // S5
                {
                    \_SB.PCI0.XHC.PMEE = Zero
                }
            }
        }
    }
}