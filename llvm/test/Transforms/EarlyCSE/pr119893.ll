; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -passes=early-cse -S %s | FileCheck %s

define i32 @samesign_hash_bug(i16 %v) {
; CHECK-LABEL: define i32 @samesign_hash_bug(
; CHECK-SAME: i16 [[V:%.*]]) {
; CHECK-NEXT:    [[ZEXT:%.*]] = zext i16 [[V]] to i32
; CHECK-NEXT:    [[ICMP_SAMESIGN:%.*]] = icmp ugt i32 [[ZEXT]], 31
; CHECK-NEXT:    [[SELECT_ICMP_SAMESIGN:%.*]] = select i1 [[ICMP_SAMESIGN]], i32 0, i32 1
; CHECK-NEXT:    [[SELECT_ICMP:%.*]] = select i1 [[ICMP_SAMESIGN]], i32 1, i32 0
; CHECK-NEXT:    ret i32 [[SELECT_ICMP]]
;
  %zext = zext i16 %v to i32
  %icmp.samesign = icmp samesign ugt i32 %zext, 31
  %select.icmp.samesign = select i1 %icmp.samesign, i32 0, i32 1
  %ashr = ashr i32 0, %select.icmp.samesign
  %icmp = icmp ugt i32 %zext, 31
  %select.icmp = select i1 %icmp, i32 1, i32 0
  %ret = add i32 %ashr, %select.icmp
  ret i32 %ret
}
