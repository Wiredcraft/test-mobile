@file:OptIn(ExperimentalGlideComposeApi::class)

package com.dorck.githuber.ui.components

import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.bumptech.glide.integration.compose.ExperimentalGlideComposeApi
import com.dorck.githuber.R
import com.dorck.githuber.ui.pages.home.mockUserList
import com.dorck.githuber.ui.wrapper.UserDisplayBean

val descriptionTextColor = Color(0XFF6D6D6D)
val dividerColor = Color(0XFFEFEFEF)

@Composable
fun GithubUserListItem(
    userData: UserDisplayBean,
    onItemClick: (() -> Unit)? = null,
    onFollowClick: (() -> Unit)? = null,
) {
    // FIXME: Too many nested layout levels, use ConstraintLayout instead.
    Column(Modifier.background(Color.White)) {
        Row(
            verticalAlignment = Alignment.CenterVertically,
            modifier = Modifier
                .fillMaxWidth()
                .background(MaterialTheme.colors.surface)
                .clickable(onClick = {})
                .padding(vertical = 16.dp)
        ) {
            Spacer(modifier = Modifier.width(20.dp))
            Surface(
                modifier = Modifier.size(32.dp),
                shape = CircleShape,
                color = MaterialTheme.colors.onSurface.copy(alpha = 0.2f)
            ) {
                Image(
                    painter = painterResource(id = R.drawable.activator_dog),
                    modifier = Modifier.size(32.dp),
                    contentDescription = "activator",
                    contentScale = ContentScale.Crop
                )
//            GlideImage(
//                model = userData.avatar,
//                contentDescription = stringResource(R.string.avatar_content_desc),
//                contentScale = ContentScale.Crop
//            )
            }
            Column(
                modifier = Modifier
                    .wrapContentWidth()
                    .weight(1.0f)
                    .padding(horizontal = 10.dp)
                    .align(Alignment.CenterVertically)
            ) {
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Text(
                        userData.username,
                        modifier = Modifier
                            .padding(end = 6.dp)
                            .weight(1.0f),
                        color = Color.Black,
                        fontSize = 14.sp,
                        maxLines = 1,
                        overflow = TextOverflow.Ellipsis
                    )
                    Text(
                        userData.score,
                        color = descriptionTextColor,
                        fontSize = 12.sp,
                    )
                }
                Text(
                    userData.profileUrl,
                    color = descriptionTextColor,
                    fontSize = 12.sp,
                    maxLines = 1,
                    overflow = TextOverflow.Ellipsis
                )
            }
            FollowButton(text = "取消关注")
            Spacer(modifier = Modifier.width(28.dp))
        }
        Divider(Modifier.fillMaxWidth().padding(horizontal = 20.dp), color = dividerColor)
    }

}

@Composable
fun FollowButton(
    text: String,
    onClick: (() -> Unit)? = null,
    bgColor: ButtonColors = ButtonDefaults.buttonColors(backgroundColor = Color(0XFF1A1A1A))
) {
    Button(
        colors = bgColor,
        modifier = Modifier
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
    GithubUserListItem(userData = defaultUserData)
}

@Preview
@Composable
fun UserListContent() {
    Box(modifier = Modifier
        .fillMaxWidth()
        .padding(top = 18.dp)) {
        LazyColumn(
            modifier = Modifier
                .fillMaxWidth()
                .padding(top = 18.dp),
//            state = userLazyListState
        ) {
            items(items = mockUserList, key = { it.id }) { user ->
                GithubUserListItem(userData = user)
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