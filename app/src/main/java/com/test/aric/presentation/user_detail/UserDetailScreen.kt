package com.test.aric.presentation.user_detail

import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.Button
import androidx.compose.material.ButtonDefaults
import androidx.compose.material.Divider
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.test.aric.R
import androidx.constraintlayout.compose.ConstraintLayout
import androidx.hilt.navigation.compose.hiltViewModel
import coil.compose.AsyncImage

@Composable
fun UserDetailScreen(
    viewModel: UserDetailViewModel = hiltViewModel()
) {
    val state = viewModel.userInfo

        ConstraintLayout {
            val (bgHeader, ivAvatar, login, subscribe, indicator, repoListTitle) = createRefs()

            Image(
                painter = painterResource(id =R.drawable.bg_round ),
                contentDescription = null,
                modifier = Modifier.constrainAs(bgHeader) {
                    top.linkTo(parent.top)
                    start.linkTo(parent.start)
                    end.linkTo(parent.end)
                }
            )

            AsyncImage(
                model = state.avatar_url,
                contentDescription = null,
                modifier = Modifier
                    .size(32.dp)
                    .clip(CircleShape)
                    .constrainAs(ivAvatar) {
                        top.linkTo(bgHeader.top)
                        start.linkTo(bgHeader.start)
                        end.linkTo(bgHeader.end)
                        bottom.linkTo(login.top)
                    }
            )


            Text(state.login,
                modifier = Modifier.constrainAs(login) {
                    top.linkTo(ivAvatar.bottom)
                    start.linkTo(bgHeader.start)
                    end.linkTo(bgHeader.end)
                    bottom.linkTo(subscribe.top)
                }
            )


            Button(
                onClick = { },
                colors = ButtonDefaults.buttonColors(backgroundColor = Color.White),
                modifier = Modifier.padding(0.dp).height(34.dp).width(76.dp).constrainAs(subscribe) {
                    top.linkTo(login.bottom)
                    start.linkTo(bgHeader.start)
                    end.linkTo(bgHeader.end)
                    bottom.linkTo(bgHeader.bottom)
                }
            ) {

                Text(
                    text = if (state.follow) "关注" else "不关注",
                    fontSize = 10.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color.Black
                )
            }


            Divider(modifier = Modifier.constrainAs(indicator) {
                top.linkTo(bgHeader.bottom)
                start.linkTo(parent.start)
                bottom.linkTo(repoListTitle.top)
            }.width(2.dp).background(Color.Black))

            Text("REPOSITORIES",  modifier = Modifier.constrainAs(repoListTitle) {
                top.linkTo(indicator.top)
                start.linkTo(indicator.end)
                bottom.linkTo(indicator.bottom)
            })

        }
    }