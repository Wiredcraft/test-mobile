@file:OptIn(ExperimentalGlideComposeApi::class)

package com.dorck.githuber.ui.components

import androidx.compose.animation.animateContentSize
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.constraintlayout.compose.ChainStyle
import androidx.constraintlayout.compose.ConstraintLayout
import androidx.constraintlayout.compose.Dimension
import com.bumptech.glide.integration.compose.ExperimentalGlideComposeApi
import com.dorck.githuber.R
import com.dorck.githuber.ui.pages.home.mockUserList
import com.dorck.githuber.ui.wrapper.UserDisplayBean

val descriptionTextColor = Color(0XFF6D6D6D)
val dividerColor = Color(0XFFEFEFEF)

@Composable
fun GithubUserListItem(
    modifier: Modifier = Modifier,
    userData: UserDisplayBean,
    text: String,
    onItemClick: (() -> Unit)? = null,
    onFollowClick: (() -> Unit)? = null,
) {
    ConstraintLayout(
        modifier = modifier
            .fillMaxWidth()
            .animateContentSize()
            .background(Color.White)
            .clickable(onClick = {})
    ) {
        val (avatar, name, score, link, button, divider) = createRefs()
        Image(
            painter = painterResource(id = R.drawable.activator_dog),
            modifier = Modifier
                .size(32.dp)
                .clip(CircleShape)
                .constrainAs(avatar) {
                    start.linkTo(parent.start, 20.dp)
                    centerVerticallyTo(parent)
                },
            contentDescription = "avatar",
            contentScale = ContentScale.Crop
        )

//            GlideImage(
//                model = userData.avatar,
//                contentDescription = stringResource(R.string.avatar_content_desc),
//                contentScale = ContentScale.Crop
//            )
        // Create a chain between `name` and `score` text.
        createHorizontalChain(name, score, chainStyle = ChainStyle.Packed(0f))
        Text(
            userData.username,
            modifier = Modifier.constrainAs(name) {
                linkTo(
                    start = avatar.end,
                    end = score.start,
                    startMargin = 10.dp,
                    // Keep offset at start
                    bias = 0f
                )
                top.linkTo(parent.top, 16.dp)
                width = Dimension.preferredWrapContent
            },
            color = Color.Black,
            fontSize = 14.sp,
            maxLines = 1,
            overflow = TextOverflow.Ellipsis
        )
        Text(
            userData.score,
            modifier = Modifier.constrainAs(score) {
                start.linkTo(name.end, 6.dp)
                top.linkTo(parent.top)
                end.linkTo(button.start, 10.dp)
                centerVerticallyTo(name)
            },
            color = descriptionTextColor,
            fontSize = 12.sp,
            maxLines = 1,
        )
        Text(
            userData.profileUrl,
            color = descriptionTextColor,
            fontSize = 12.sp,
            maxLines = 1,
            overflow = TextOverflow.Ellipsis,
            modifier = Modifier.constrainAs(link) {
                linkTo(
                    start = avatar.end,
                    end = button.start,
                    top = name.bottom,
                    bottom = parent.bottom,
                    startMargin = 10.dp,
                    endMargin = 10.dp,
                    bottomMargin = 16.dp,
                    horizontalBias = 0f
                )
            }
        )

        CommonButton(
            text = text,
            modifier = Modifier.constrainAs(button) {
                top.linkTo(parent.top)
                bottom.linkTo(parent.bottom)
                end.linkTo(parent.end, 28.dp)
            },
            onClick = onFollowClick
        )

        // Place bottom divider
        Divider(
            Modifier
                .constrainAs(divider) {
                    bottom.linkTo(parent.bottom)
                    width = Dimension.fillToConstraints
                }
                .padding(horizontal = 20.dp),
            color = dividerColor
        )
    }
}

@Composable
fun CommonButton(
    text: String,
    modifier: Modifier = Modifier,
    onClick: (() -> Unit)? = null,
    bgColor: ButtonColors = ButtonDefaults.buttonColors(backgroundColor = Color(0XFF1A1A1A))
) {
    Button(
        colors = bgColor,
        modifier = modifier
            .width(55.dp)
            .height(24.dp),
        contentPadding = PaddingValues(0.dp),
        onClick = { onClick?.invoke() }) {
        Text(text = text, fontSize = 10.sp, color = Color.White)
    }

}

@Preview
@Composable
fun PreviewProfileCard() {
    GithubUserListItem(userData = defaultUserData, text = "Follow")
}

@Preview
@Composable
fun UserListContent() {
    Box(
        modifier = Modifier
            .fillMaxWidth()
            .padding(top = 18.dp)
    ) {
        LazyColumn(
            modifier = Modifier
                .fillMaxWidth()
                .padding(top = 18.dp),
//            state = userLazyListState
        ) {
            items(items = mockUserList, key = { it.id }) { user ->
                GithubUserListItem(userData = user, text = "关注")
            }
        }
    }
}

val defaultUserData = UserDisplayBean(
    "12414",
    "Moosdasasasassaasgagagagagagagsasgagsagsagagaqqqqdsdsdsafasf",
    "https://avatars.githubusercontent.com/u/233047?v=4",
    "https://github.com/moos",
    "12.0"
)