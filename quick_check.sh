#!/bin/bash
# look for MK keywords and ESP blocks
grep -i "Mulliken charges" axle_esp.log -n || true
grep -i "Merz-Kollman" axle_esp.log -n || true
grep -i "ESP charge" axle_esp.log -n || true
# Or check for the grid/points header espgen expects:
grep -n "Point Charges from ESP Fit" axle_esp.log || true

