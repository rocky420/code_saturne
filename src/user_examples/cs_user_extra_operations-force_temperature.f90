!-------------------------------------------------------------------------------

!VERS

! This file is part of Code_Saturne, a general-purpose CFD tool.
!
! Copyright (C) 1998-2013 EDF S.A.
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

!===============================================================================
! Purpose:
! -------

! \file cs_user_extra_operations-force_temperature.f90
! This is an example of cs_user_extra_operations.f90 which
! performs forced temperature

!-------------------------------------------------------------------------------

!-------------------------------------------------------------------------------
! Arguments
!______________________________________________________________________________.
!  mode           name          role                                           !
!______________________________________________________________________________!
!> \param[in]     nvar          total number of variables
!> \param[in]     nscal         total number of scalars
!> \param[in]     nbpmax        max. number of particles allowed
!> \param[in]     nvp           number of particle-defined variables
!> \param[in]     nvep          number of real particle properties
!> \param[in]     nivep         number of integer particle properties
!> \param[in]     ntersl        number of return coupling source terms
!> \param[in]     nvlsta        number of Lagrangian statistical variables
!> \param[in]     nvisbr        number of boundary statistics
!> \param[in]     itepa         integer particle attributes
!>                                (containing cell, ...)
!> \param[in]     dt            time step (per cell)
!> \param[in]     rtp, rtpa     calculated variables at cell centers
!>                               (at current and previous time steps)
!> \param[in]     propce        physical properties at cell centers
!> \param[in]     propfb        physical properties at boundary face centers
!> \param[in]     ettp, ettpa   particle-defined variables
!> \param[in]                    (at current and previous time steps)
!> \param[in]     tepa          real particle properties
!> \param[in]                    (statistical weight, ...
!> \param[in]     statis        statistic means
!> \param[in]     stativ        accumulator for variance of volume statisitics
!> \param[in]     tslagr        Lagrangian return coupling term
!> \param[in]                    on carrier phase
!> \param[in]     parbor        particle interaction properties
!> \param[in]                    on boundary faces
!_______________________________________________________________________________



subroutine cs_user_extra_operations &
!==================================

 ( nvar   , nscal  ,                                              &
   nbpmax , nvp    , nvep   , nivep  , ntersl , nvlsta , nvisbr , &
   itepa  ,                                                       &
   dt     , rtpa   , rtp    , propce , propfb ,                   &
   ettp   , ettpa  , tepa   , statis , stativ , tslagr , parbor )

!===============================================================================

!===============================================================================
! Module files
!===============================================================================

use paramx
use dimens, only: ndimfb
use pointe
use numvar
use optcal
use cstphy
use cstnum
use entsor
use lagpar
use lagran
use parall
use period
use ppppar
use ppthch
use ppincl
use mesh
use field

!===============================================================================

implicit none

! Arguments

integer          nvar   , nscal
integer          nbpmax , nvp    , nvep  , nivep
integer          ntersl , nvlsta , nvisbr

integer          itepa(nbpmax,nivep)

double precision dt(ncelet), rtp(ncelet,*), rtpa(ncelet,*)
double precision propce(ncelet,*)
double precision propfb(ndimfb,*)
double precision ettp(nbpmax,nvp) , ettpa(nbpmax,nvp)
double precision tepa(nbpmax,nvep)
double precision statis(ncelet,nvlsta), stativ(ncelet,nvlsta-1)
double precision tslagr(ncelet,ntersl)
double precision parbor(nfabor,nvisbr)


! Local variables

!< [loc_var_dec]
integer          iel
integer          iscal
!< [loc_var_dec]

!===============================================================================

!===============================================================================
! Initialization
!===============================================================================

!===============================================================================
! Example: set temperature to 20 in a given region starting at t = 12s
! --------------------------------------------------------------------

! Do this with precaution...
! The user is responsible for the validity of results.
!===============================================================================

!< [example_1]
iscal = iscalt

if (ttcabs .ge. 12.d0) then

  if (iscal.gt.0 .and. iscal.le.nscal) then
    do iel = 1, ncel
      rtp(iel,isca(iscal)) = 20.d0
    enddo
  endif

  write(nfecra,3000)

endif
!< [example_1]

 3000 format                                                       &
  (/,                                                              &
   ' User modification of variables at the end of the time step',  &
   /)

return
end subroutine cs_user_extra_operations
