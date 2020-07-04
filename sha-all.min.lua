
local e,t,a,o,i,n,s,h,r,d,l=table.unpack or unpack,table.concat,string.byte,string.char,string.rep,string.sub,string.format,math.floor,math.ceil,math.min,math.max local u,c,m,f,w,y,p,v function f(H,R)return(H*2^R)%4294967296 end function w(H,R)H=
H%4294967296/2^R return H-H%1 end
function y(H,R)
H=H%4294967296*2^R local D=H%4294967296 return D+ (H-D)/4294967296 end function p(H,R)H=H%4294967296/2^R local D=H%1
return D*4294967296+ (H-D)end local b={}
for H=0,65535 do local R=H%256
local D=(H-R)/256 local L=0 local U=1 while R*D~=0 do local C=R%2 local M=D%2 L=L+C*M*U R=(R-C)/2 D=(D-M)/2 U=
U*2 end b[H]=L end
local function g(H,R,D)local L=H%4294967296 local U=R%4294967296 local C=L%256 local M=U%256
local F=b[C+M*256]H=L-C R=(U-M)/256 C=H%65536 M=R%256 F=F+b[C+M]*256 H=(H-C)/
256 R=(R-M)/256 C=H%65536+R%256
F=F+b[C]*65536 F=F+b[(H+R-C)/256]*16777216 if D then
F=L+U-D*F end return F end function u(H,R)return g(H,R)end function c(H,R)return g(H,R,1)end function m(H,R,D)
if D then R=g(R,D,2)end return g(H,R,2)end function v(H)
return s("%08x",H%4294967296)end local k,q,j,x={},{},{},{}local z={[224]={},[256]=x}
local _,E={[384]={},[512]=j},{[384]={},[512]=x}local T={}
local function A(R,D,L,U,C,M)
for H=C,M+C-1,64 do
for J=1,16 do H=H+4 local X,Z,ee,et=a(L,H-3,H)U[J]=
((X*256+Z)*256+ee)*256+et end for J=17,64 do local X,Z=U[J-15],U[J-2]
U[J]=m(p(X,7),y(X,14),w(X,3))+
m(y(Z,15),y(Z,13),w(Z,10))+U[J-7]+U[J-16]end
local F,W,Y,P,V,B,G,K,Q=R[1],R[2],R[3],R[4],R[5],R[6],R[7],R[8]
for J=1,64 do
Q=
m(p(V,6),p(V,11),y(V,7))+u(V,B)+u(-1-V,G)+K+D[J]+U[J]K=G G=B B=V V=Q+P P=Y Y=W W=F F=Q+u(P,Y)+u(F,m(P,Y))+
m(p(F,2),p(F,13),y(F,10))end
R[1],R[2],R[3],R[4]=(F+R[1])%4294967296,(W+R[2])%4294967296,(Y+R[3])%
4294967296,(P+R[4])%4294967296
R[5],R[6],R[7],R[8]=(V+R[5])%4294967296,(B+R[6])%4294967296,(G+R[7])%
4294967296,(K+R[8])%4294967296 end end
local function O(H,R,D,L,U,C,M,F)
for W=M,F+M-1,128 do
for el=1,32 do W=W+4 local eu,ec,em,ef=a(U,W-3,W)C[el]=
((eu*256+ec)*256+em)*256+ef end local Y,P
for el=17*2,80*2,2 do local eu,ec,em,ef=C[el-30],C[el-31],C[el-4],C[el-5]
Y=

m(
w(eu,1)+f(ec,31),w(eu,8)+f(ec,24),w(eu,7)+f(ec,25))+
m(w(em,19)+f(ef,13),f(em,3)+w(ef,29),w(em,6)+f(ef,26))+C[el-14]+C[el-32]P=Y%4294967296
C[el-1]=


m(w(ec,1)+f(eu,31),w(ec,8)+f(eu,24),w(ec,7))+m(w(ef,19)+f(em,13),f(ef,3)+w(em,29),w(ef,6))+C[el-15]+C[el-33]+ (Y-P)/4294967296 C[el]=P end local V,B,G,K,Q,J,X,Z,ee=H[1],H[2],H[3],H[4],H[5],H[6],H[7],H[8]
local et,ea,eo,ei,en,es,eh,er,ed=R[1],R[2],R[3],R[4],R[5],R[6],R[7],R[8]
for el=1,80 do local eu=2*el
Y=


m(w(Q,14)+f(en,18),w(Q,18)+f(en,14),f(Q,23)+w(en,9))+u(Q,J)+u(-1-Q,X)+Z+D[el]+C[eu]ee=Y%4294967296
ed=


m(w(en,14)+f(Q,18),w(en,18)+f(Q,14),f(en,23)+w(Q,9))+u(en,es)+u(-1-en,eh)+er+L[el]+C[eu-1]+ (Y-ee)/4294967296 Z=X er=eh X=J eh=es J=Q es=en Y=ee+K Q=Y%4294967296
en=ed+ei+ (Y-Q)/4294967296 K=G ei=eo G=B eo=ea B=V ea=et
Y=ee+u(K,G)+u(B,m(K,G))+m(w(B,28)+f(ea,4),
f(B,30)+w(ea,2),f(B,25)+w(ea,7))V=Y%4294967296
et=
ed+ (u(ei,eo)+u(ea,m(ei,eo)))+
m(w(ea,28)+f(B,4),f(ea,30)+w(B,2),f(ea,25)+w(B,7))+ (Y-V)/4294967296 end Y=H[1]+V P=Y%4294967296 H[1],R[1]=P,
(R[1]+et+ (Y-P)/4294967296)%4294967296 Y=H[2]+B
P=Y%4294967296
H[2],R[2]=P,(R[2]+ea+ (Y-P)/4294967296)%4294967296 Y=H[3]+G P=Y%4294967296 H[3],R[3]=P,
(R[3]+eo+ (Y-P)/4294967296)%4294967296 Y=H[4]+K
P=Y%4294967296
H[4],R[4]=P,(R[4]+ei+ (Y-P)/4294967296)%4294967296 Y=H[5]+Q P=Y%4294967296 H[5],R[5]=P,
(R[5]+en+ (Y-P)/4294967296)%4294967296 Y=H[6]+J
P=Y%4294967296
H[6],R[6]=P,(R[6]+es+ (Y-P)/4294967296)%4294967296 Y=H[7]+X P=Y%4294967296 H[7],R[7]=P,
(R[7]+eh+ (Y-P)/4294967296)%4294967296 Y=H[8]+Z
P=Y%4294967296
H[8],R[8]=P,(R[8]+er+ (Y-P)/4294967296)%4294967296 end end
do
local function H(W,Y,P,V)local B={}local G=0 local K=0.0 local Q=1.0
for J=1,V do local X=0 for ee=l(1,J+1-#Y),d(J,#W)do
X=X+W[ee]*Y[J+1-ee]end G=G+X*P local Z=G%16777216 B[J]=Z
G=h(G/16777216)K=K+Z*Q Q=Q*2^24 end return B,K end local R,D,L,U=0,{4,1,2,-2,2},4,{1}local C,M,F=x,j,0
repeat L=L+D[L%6]local W=1
repeat
W=W+D[W%6]
if W*W>L then R=R+1 local Y=L^ (1/3)local P=H({h(Y*2^40)},U,1,2)local V,B=H(P,H(P,P,1,4),
-1,4)
local G=P[2]%65536*65536+h(P[1]/256)
local K=P[1]%256*16777216+h(B* (2^-56/3)*Y/L)q[R],k[R]=G,K
if R<17 then Y=L^ (1/2)P=H({h(Y*2^40)},U,1,2)V,B=H(P,P,
-1,2)
G=P[2]%65536*65536+h(P[1]/256)K=P[1]%256*16777216+h(B*2^-17/Y)z[224][
R+F]=K C[R+F],M[R+F]=G,K
if R==8 then C,M,F=E[384],_[384],-8 end end break end until L%W==0 until R>79 end
for H=224,256,32 do local R,D={},{}for L=1,8 do R[L]=m(j[L],0xa5a5a5a5)
D[L]=m(x[L],0xa5a5a5a5)end
O(R,D,k,q,"SHA-512/"..tonumber(H)..
"\128"..i("\0",115).."\88",T,0,128)_[H]=R E[H]=D end
local function I(H,R)local D,L,U={e(z[H])},0,""
local function C(M)
if M then
if U then L=L+#M local F=0 if U~=""and#U+#M>=64 then F=64-#U A(D,q,U..
n(M,1,F),T,0,64)U=""end
local W=#M-F local Y=W%64 A(D,q,M,T,F,W-Y)U=U..n(M,#M+1-Y)return C else
error("Adding more chunks is not allowed after asking for final result",2)end else
if U then local F={U,"\128",i("\0",(-9-L)%64+1)}U=nil L=L* (8/
256^7)
for Y=4,10 do L=L%1*256 F[Y]=o(h(L))end F=t(F)A(D,q,F,T,0,#F)local W=H/32 for Y=1,W do D[Y]=v(D[Y])end
D=t(D,"",1,W)end return D end end if R then return C(R)()else return C end end
local function N(H,R)local D,L,U,C=0,"",{e(_[H])},{e(E[H])}
local function M(F)
if F then
if L then D=D+#F local W=0
if
L~=""and#L+#F>=128 then W=128-#L O(U,C,k,q,L..n(F,1,W),T,0,128)L=""end local Y=#F-W local P=Y%128 O(U,C,k,q,F,T,W,Y-P)
L=L..n(F,#F+1-P)return M else
error("Adding more chunks is not allowed after asking for final result",2)end else
if L then
local W={L,"\128",i("\0",(-17-D)%128+9)}L=nil D=D* (8/256^7)
for P=4,10 do D=D%1*256 W[P]=o(h(D))end W=t(W)O(U,C,k,q,W,T,0,#W)local Y=r(H/64)for P=1,Y do
U[P]=v(C[P])..v(U[P])end C=nil U=t(U,"",1,Y):sub(1,H/4)end return U end end if R then return M(R)()else return M end end
local S={sha224=function(H)return I(224,H)end,sha256=function(H)return I(256,H)end,sha384=function(H)return N(384,H)end,sha512=function(H)return
N(512,H)end,sha512_224=function(H)return N(224,H)end,sha512_256=function(H)return N(256,H)end}return S
