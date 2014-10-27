!-------------------------------------------------------------------------------

! This file is part of Code_Saturne, a general-purpose CFD tool.
!
! Copyright (C) 1998-2014 EDF S.A.
!
! This program is free software; you can redistribute it and/or modify it under
! the terms of the GNU General Public License as published by the Free Software
! Foundation; either version 2 of the License, or (at your option) any later
! version.
!
! This program is distributed in the hope that it will be useful, but WITHOUT
! ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
! FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
! details.
!
! You should have received a copy of the GNU General Public License along with
! this program; if not, write to the Free Software Foundation, Inc., 51 Franklin
! Street, Fifth Floor, Boston, MA 02110-1301, USA.

!-------------------------------------------------------------------------------

!> \file usatch.f90
!> \brief Routines for user defined atmospheric chemical scheme
!> \remarks
!>  These routines should be generated by SPACK
!>  See CEREA: http://cerea.enpc.fr/polyphemus

!> kinetic
!> \brief Computation of kinetic rates for atmospheric chemistry
!------------------------------------------------------------------------------

!------------------------------------------------------------------------------
! Arguments
!------------------------------------------------------------------------------
!   mode          name              role
!------------------------------------------------------------------------------
!> \param[in]     nr                total number of chemical reactions
!> \param[in]     option_photolysis flag to activate or not photolysis reactions
!> \param[in]     azi               solar zenith angle
!> \param[in]     att               atmospheric attenuation variable
!> \param[in]     temp              temperature
!> \param[in]     press             pressure
!> \param[in]     xlw               water massic fraction
!> \param[out]    rk(nr)            kinetic rates
!______________________________________________________________________________

subroutine kinetic(nr,rk,temp,xlw,press,azi,att,                  &
     option_photolysis)

use entsor

implicit none

! Arguments

integer nr
double precision rk(nr),temp,xlw,press
double precision azi, att
integer option_photolysis


return

!--------
! Formats
!--------

end subroutine kinetic


!===============================================================================

!> fexchem
!> \brief Computation of the chemical production terms
!------------------------------------------------------------------------------

!------------------------------------------------------------------------------
! Arguments
!------------------------------------------------------------------------------
!   mode          name              role
!------------------------------------------------------------------------------
!> \param[in]     nr                total number of chemical reactions
!> \param[in]     ns                total number of chemical species
!> \param[in]     y                 concentrations vector
!> \param[in]     rk                kinetic rates
!> \param[in]     zcsourc           source term
!> \param[in]     convers_factor    conversion factors
!> \param[out]    chem              chemical production terms for every species
!______________________________________________________________________________

subroutine fexchem(ns,nr,y,rk,zcsourc,convers_factor,chem)

use entsor

implicit none

! Arguments

integer nr,ns
double precision rk(nr),y(ns),chem(ns),zcsourc(ns)
double precision convers_factor(ns)

! Local variables


return

!--------
! Formats
!--------

end subroutine fexchem


!===============================================================================

!> jacdchemdc
!> \brief Computation of the Jacobian matrix for atmospheric chemistry
!------------------------------------------------------------------------------

!------------------------------------------------------------------------------
! Arguments
!------------------------------------------------------------------------------
!   mode          name               role
!------------------------------------------------------------------------------
!> \param[in]     nr                 total number of chemical reactions
!> \param[in]     ns                 total number of chemical species
!> \param[in]     y                  concentrations vector
!> \param[in]     convers_factor     conversion factors of mug/m3 to
!>                                   molecules/cm3
!> \param[in]     convers_factor_jac conversion factors for the Jacobian matrix
!>                                   (Wmol(i)/Wmol(j))
!> \param[in]     rk                 kinetic rates
!> \param[out]    jacc               Jacobian matrix
!______________________________________________________________________________

subroutine jacdchemdc(ns,nr,y,convers_factor,                     &
                    convers_factor_jac,rk,jacc)

use entsor

implicit none

! Arguments

integer nr,ns
double precision rk(nr),y(ns),jacc(ns,ns)
double precision convers_factor(ns)
double precision convers_factor_jac(ns,ns)

! Local variables



return

!--------
! FORMATS
!--------

end subroutine jacdchemdc


!===============================================================================

!> rates
!> \brief Computation of reaction rates
!------------------------------------------------------------------------------

!------------------------------------------------------------------------------
! Arguments
!------------------------------------------------------------------------------
!   mode          name               role
!------------------------------------------------------------------------------
!> \param[in]     nr                 total number of chemical reactions
!> \param[in]     ns                 total number of chemical species
!> \param[in]     rk                 kinetic rates
!> \param[in]     y                  concentrations vector
!> \param[out]    w                  reaction rates
!______________________________________________________________________________

subroutine rates(ns,nr,rk,y,w)

use entsor

implicit none

! Arguments

integer nr,ns
double precision rk(nr),y(ns)
double precision w(nr)

! Local variables

!--------
! FORMATS
!--------

return
end subroutine rates


!===============================================================================

!> dratedc
!> \brief Computation of derivatives of reaction rates
!------------------------------------------------------------------------------

!------------------------------------------------------------------------------
! Arguments
!------------------------------------------------------------------------------
!   mode          name               role
!------------------------------------------------------------------------------
!> \param[in]     nr                 total number of chemical reactions
!> \param[in]     ns                 total number of chemical species
!> \param[in]     rk                 kinetic rates
!> \param[in]     y                  concentrations vector
!> \param[out]    dw                 derivatives of reaction rates
!______________________________________________________________________________

subroutine dratedc(ns,nr,rk,y,dw)

use entsor

implicit none

! Arguments

integer nr,ns
double precision rk(nr),y(ns)
double precision dw(nr,ns)

! Local variables

!--------
! FORMATS
!--------

return
end subroutine dratedc


!===============================================================================

!> lu_decompose
!> \brief Computation of LU factorization of matrix m
!------------------------------------------------------------------------------

!------------------------------------------------------------------------------
! Arguments
!------------------------------------------------------------------------------
!   mode          name               role
!------------------------------------------------------------------------------
!> \param[in]     ns                 matrix row number from the chemical
!>                                   species number
!> \param[in,out] m                  on entry, an invertible matrix.
!>                                   On exit, an LU factorization of m
!______________________________________________________________________________

subroutine lu_decompose (ns,m)

use entsor

implicit none

! Arguments

integer ns
double precision m(ns,ns)

! Local variables


!--------
! FORMATS
!--------

return
end subroutine lu_decompose


!===============================================================================

!> lu_solve
!> \brief Resolution of MY=X where M is an LU factorization computed
!>        by lu_decompose
!------------------------------------------------------------------------------

!------------------------------------------------------------------------------
! Arguments
!------------------------------------------------------------------------------
!   mode          name             role
!------------------------------------------------------------------------------
!> \param[in]     ns               matrix row number from the chemical
!>                                 species number
!> \param[in]     m                an LU factorization computed by lu_decompose
!> \param[in,out] x                on entry, the right-hand side of the equation
!                                  on exit, the solution of the equation
!______________________________________________________________________________

subroutine lu_solve (ns, m, x)

use entsor

implicit none

! Arguments

integer ns
double precision m(ns,ns)
double precision x(ns)

! Local variables

!--------
! FORMATS
!--------

return
end subroutine lu_solve

