package com.test.aric.presentation.search_user_list.components

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.Button
import androidx.compose.material.ButtonDefaults
import androidx.compose.material.Divider
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.constraintlayout.compose.ChainStyle
import androidx.constraintlayout.compose.ConstraintLayout
import androidx.constraintlayout.compose.Dimension
import coil.compose.AsyncImage
import com.test.aric.data.remote.dto.UserInfo

@Composable
fun SearchUserListItem(
    index:Int,
    userInfo: UserInfo,
    onItemClick: (UserInfo) -> Unit,
    onFollowButtonClick: (UserInfo) -> Unit,
    isShowButton:Boolean = true
) {
        ConstraintLayout(modifier = Modifier
            .clickable { onItemClick(userInfo) }
            .height(64.dp)
            .fillMaxWidth()) {
            val (avatar, login, url, score, divider, subscribe,space) = remember {
                createRefs()
            }
            createVerticalChain(login,url, chainStyle = ChainStyle.Packed)

            AsyncImage(
                model = userInfo.avatar_url,
                contentDescription = null,
                modifier = Modifier
                    .size(32.dp)
                    .clip(CircleShape)
                    .constrainAs(avatar) {
                        top.linkTo(parent.top)
                        start.linkTo(parent.start)
                        bottom.linkTo(parent.bottom)
                    }
            )

            Text(
                text = "${userInfo.login}--${index}",
                fontSize = 14.sp,
                fontWeight = FontWeight.Bold,
                maxLines = 1,
                overflow = TextOverflow.Ellipsis,
                modifier = Modifier.constrainAs(login) {
                    top.linkTo(avatar.top)
                    start.linkTo(avatar.end, margin = 8.dp)
                    end.linkTo(score.start)
                    width = Dimension.preferredWrapContent
                    bottom.linkTo(url.top)
                }
            )

            Text(
                text = userInfo.score,
                fontSize = 10.sp,
                textAlign = TextAlign.Center,
                modifier = Modifier.constrainAs(score) {
                    top.linkTo(login.top)
                    start.linkTo(login.end, margin = 6.dp)
                    end.linkTo(space.start)
                    bottom.linkTo(login.bottom)
                    width = Dimension.wrapContent
                }
            )

            Spacer(modifier =Modifier.background(Color.White).constrainAs(space){
                width = Dimension.fillToConstraints
                top.linkTo(login.top)
                bottom.linkTo(login.bottom)
                start.linkTo(score.end, margin = 6.dp)
                end.linkTo(subscribe.start)
            } )

            Text(
                text = userInfo.html_url,
                fontSize = 12.sp,
                maxLines = 1,
                overflow = TextOverflow.Ellipsis,
                modifier = Modifier.constrainAs(url) {
                    top.linkTo(login.bottom)
                    start.linkTo(login.start)
                    end.linkTo(subscribe.start)
                    width = Dimension.ratio("0")
                    bottom.linkTo(parent.bottom)
                }
            )

            Divider(
                color = Color.LightGray,
                modifier = Modifier.constrainAs(divider) {
                    start.linkTo(parent.start)
                    end.linkTo(parent.end)
                    bottom.linkTo(parent.bottom)
                    width = Dimension.matchParent
                }
            )

            if (isShowButton){
                Button(
                    onClick = { onFollowButtonClick(userInfo)},
                    colors = ButtonDefaults.buttonColors(backgroundColor = Color.Black),
                    modifier = Modifier.padding(0.dp).height(34.dp).width(76.dp).constrainAs(subscribe) {
                        top.linkTo(parent.top)
                        end.linkTo(parent.end)
                        bottom.linkTo(parent.bottom)
                    }
                ) {

                    Text(
                        text = if (userInfo.follow) "关注" else "不关注",
                        fontSize = 10.sp,
                        fontWeight = FontWeight.Bold,
                        color = Color.White
                    )
                }
            }

        }
    }
